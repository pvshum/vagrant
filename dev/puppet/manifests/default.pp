class debian-setup {
    exec { "import-gpg":
        command => "/usr/bin/wget -q http://www.dotdeb.org/dotdeb.gpg -O -| /usr/bin/apt-key add -"
    }

    file { "/etc/apt/sources.list.d/dotdeb.list":
        ensure => file,
        owner => root,
        group => root,
        source => "puppet:///modules/system/dotdeb.list",
        require => Exec["import-gpg"],
    }

    exec { "/usr/bin/apt-get update":
        require => [File["/etc/apt/sources.list.d/dotdeb.list"], Exec["import-gpg"]],
    }
}

class essentials {
    package { "vim-nox":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "git":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "mercurial":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "htop":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "curl":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "ntp":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "ntpdate":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "iotop":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "iftop":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "tcpdump":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "zsh":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }

    package { "ruby":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
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

class apache {
    package { "apache2":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
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
        require => [Exec["/usr/bin/apt-get update"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-suhosin":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-mysql":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-memcache":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-mcrypt":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-xdebug":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-intl":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
    package { "php5-sqlite":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["restart-apache2"],
    }
}

class mysql {
    package { "mysql-server":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }
    package { "mysql-client":
        ensure => present,
        require => [Exec["/usr/bin/apt-get update"]],
    }
}

node default {
    include debian-setup
    include essentials
    include apache
    include php
#    include mysql
}
