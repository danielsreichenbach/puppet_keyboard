# = Define: keyboard::params
#
# Provides default parameters for keyboard configuration.
#
# == Parameters
#
class keyboard::params {
  case $::osfamily {
    'Debian': {
      $model           = 'pc105'
      $layout          = 'us'
      $variant         = ''
      $options         = ''
      $backspace       = 'guess'
      $ensure          = 'present',
      $autoupgrade     = false,
      $package         = 'keyboard-configuration'
      $default_file    = '/etc/default/keyboard'
      $update_command  = 'dpkg-reconfigure -f noninteractive keyboard-configuration'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
    }
  }
}
