class jenkins_sphinx($version = "installed", $scripts_dir = '/opt') {

    include jenkins

    $jenkins_user = $jenkins::tomcat_package

    package { 'sphinxsearch':
        ensure => "$version"
    }

    if !defined(File["$scripts_dir"]) {
        file { "$scripts_dir":
            ensure => 'directory',
        }
    }
  
    $job_script_filename = 'test-sphinx-conf.sh'

    file { "$scripts_dir/$job_script_filename":
        ensure => 'present',
        owner => "$jenkins_user",
        group => "$jenkins_user",
        mode => '0774',
        source => "puppet:///modules/jenkins_sphinx/$job_script_filename",
        require => Package["$jenkins::tomcat_package"]
    }

}
