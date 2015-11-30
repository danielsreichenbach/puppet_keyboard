class keyboard::params {

  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $model             = 'pc105'
      $layout            = 'us'
      $variant           = ''
      $options           = ''
      $backspace         = 'guess'
      $package           = 'keyboard-configuration'
      $default_file      = '/etc/default/keyboard'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
