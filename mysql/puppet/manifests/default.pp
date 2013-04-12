class system-setup {
    exec { "apt-update":
        command => "/usr/bin/apt-get update"
    }

    package { "curl":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "ntp":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "ntpdate":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "htop":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "iotop":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "iftop":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "tcpdump":
        ensure => present,
        require => [Exec["apt-update"]],
    }

}

class essentials {
    package { "vim-nox":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "git":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "mercurial":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "zsh":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "ruby":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "rubygems":
        ensure => present,
        require => [Package["ruby"]],
    }

    package { "rake":
        ensure => present,
        require => [Package["ruby"]],
    }
}

class mysql {
    package { "mysql-server":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    package { "mysql-client":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    service { "mysql":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["mysql-server"],
    }
}

class mongodb {
    package { "mongodb":
        ensure => present,
        require => [Exec["apt-update"]],
    }

    service { "mongodb":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["mongodb"],
    }
}

class apache {
    package { "apache2":
        ensure => present,
        require => [Exec["apt-update"]],
    }
    package { "libapache2-mod-php5":
        ensure => present,
        require => [Package["apache2"]],
    }

    service { "apache2":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["apache2"],
    }

    exec { "restart-apache2":
        command => "/etc/init.d/apache2 restart",
        refreshonly => true,
    }
}

class php {
    package { "php5-common":
        ensure => present,
        require => [Exec["apt-update"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-mysql":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-mcrypt":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-intl":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-curl":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
}

node default {
    include system-setup
    include essentials
    include mysql
    include apache
    include php
    include mongodb
}
