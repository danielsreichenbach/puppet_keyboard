# Class: keyboard
#
# This module manages keyboard
#
# Parameters:
#   [*model*]
#     Default: pc105
#
#   [*layout*]
#     Default: us
#
#   [*variant*]
#     Default: empty
#
#   [*options*]
#     Default: empty
#
#   [*backspace*]
#     Default: guess
#
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs keyboard-configuration package, sets keyboard-related environment
#   variables in the appropriate system-wide configuration file.
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'keyboard':
#     layout  => 'fr',
#     variant => 'latin9'
#   }
#
# [Remember: No empty lines between comments and class definition]
class keyboard (
  $model             = $keyboard::params::model,
  $layout            = $keyboard::params::layout,
  $variant           = $keyboard::params::variant,
  $options           = $keyboard::params::options,
  $backspace         = $keyboard::params::backspace,
  $ensure            = 'present',
  $autoupgrade       = false,
  $package           = $keyboard::params::package,
) inherits keyboard::params {

  case $ensure {
    /(present)/: {
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
      # ALL locales support
      if $locales == ['ALL'] {
        $config_ensure = 'link'
      } else {
        $config_ensure = 'file'
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

  file { $default_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/keyboard.erb"),
  notify  => Exec['update-keyboard'],
  }

  exec { 'update-keyboard':
    command     => '/usr/sbin/dpkg-reconfigure -f noninteractive keyboard-configuration',
    refreshonly => true,
    path        => ['/usr/local/bin', '/usr/bin', '/bin', '/usr/local/sbin', '/usr/sbin', '/sbin'],
    require     => [ File[$default_file], Package[$package], ],
    timeout     => 900
  }
}
