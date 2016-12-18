# = Define: ::keyboard::init
#
# This module manages keyboard
#
# == Parameters
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
#     Only set this, if your platform is not supported.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs keyboard configuration package, sets keyboard-related environment
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
class keyboard (
    $model          = $keyboard::params::model,
    $layout         = $keyboard::params::layout,
    $variant        = $keyboard::params::variant,
    $options        = $keyboard::params::options,
    $backspace      = $keyboard::params::backspace,
    $ensure         = $keyboard::params::ensure,
    $autoupgrade    = $keyboard::params::autoupgrade,
    $package        = $keyboard::params::package,
    $default_file   = $keyboard::params::default_file,
    $update_command = $keyboard::params::update_command,
  ) inherits keyboard::params {
    validate_string($model)
    validate_string($layout)
    validate_string($variant)
    validate_string($options)
    validate_string($backspace)
    validate_string($package)
    validate_absolute_path($default_file)
    validate_string($update_command)

    case $ensure {
        /(present)/: {
            if $autoupgrade == true {
                $package_ensure = 'latest'
            } else {
                $package_ensure = 'present'
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
        command     => $update_command,
        refreshonly => true,
        path        => [
            '/usr/local/bin',
            '/usr/bin',
            '/bin',
            '/usr/local/sbin',
            '/usr/sbin',
            '/sbin'
        ],
        require     => [ File[$default_file], Package[$package], ],
        timeout     => 900
    }
}
