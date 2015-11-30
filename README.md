# puppet-keyboard

Manage keyboard via Puppet

## Installation

Clone this repo to a "keyboard" directory under your Puppet modules directory:

    git clone git@github.com:nervo/puppet_keyboard.git keyboard


## Usage

By default, *us* layout and *pc105* model will be generated.

```
class { 'keyboard': }
```

Configure layout.

```
class { 'keyboard'':
  layout => 'fr'
}
```

Configure variant.

```
class { 'keyboard'':
  layout  => 'de',
  variant => 'nodeadkeys'
}
```
