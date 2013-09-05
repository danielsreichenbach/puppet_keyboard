class keyboard (
  $model     = 'pc105',
  $layout    = 'us',
  $variant   = '',
  $options   = '',
  $backspace = 'guess'
) {

  package { 'keyboard-configuration':
    ensure => present
  }

  file { '/etc/default/keyboard':
    content => inline_template('# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="<%= model %>"
XKBLAYOUT="<%= layout %>"
XKBVARIANT="<%= variant %>"
XKBOPTIONS="<%= options %>"

BACKSPACE="<%= backspace %>"
')
  }

  exec { 'apply':
    command     => '/usr/sbin/dpkg-reconfigure -f noninteractive keyboard-configuration',
    subscribe   => File['/etc/default/keyboard'],
    require     => File['/etc/default/keyboard'],
    refreshonly => true
  }
}
