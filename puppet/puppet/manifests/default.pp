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

node default {
    include system-setup
    include essentials
}
