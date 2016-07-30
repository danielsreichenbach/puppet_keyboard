#
# Provides defaults for the keyboard module parameters.
#

class keyboard::params {
    case $::osfamily {
        'Debian': {
            $model             = 'pc105'
            $layout            = 'us'
            $variant           = ''
            $options           = ''
            $backspace         = 'guess'
            $package           = 'keyboard-configuration'
            $default_file      = '/etc/default/keyboard'
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
        }
    }
}
