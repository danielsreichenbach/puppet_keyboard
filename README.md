Puppet Keyboard Module
======================

Description
-----------

Module for configuring keyboard layout.

Installation
------------

Clone this repo to a "keyboard" directory under your Puppet modules directory:

    git clone git@github.com:nervo/puppet_keyboard.git keyboard

Usage
-----

    class { 'keyboard':
      layout  => 'fr',
      variant => 'latin9'
    }
