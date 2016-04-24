# puppet-keyboard

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with keyboard](#setup)
    * [What keyboard affects](#what-keyboard-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with keyboard](#beginning-with-keyboard)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This Puppet module manages keyboard settings.

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What keyboard affects

* system package for keyboard management,
* keyboard configuration files.

### Beginning with keyboard

To use the **keyboard** module with default parameters declared the `keyboard`
class

```puppet
include keyboard
```

## Usage

### Configure the keyboard layout

```
class { 'keyboard'':
    layout => 'en'
}
```

### Configure the keyboard variant.

```
class { 'keyboard'':
    layout  => 'de',
    variant => 'nodeadkeys'
}
```

## Reference

### Classes

#### Public classes

* [`keyboard`](#class-keyboard)

#### Private classes

* `keyboard::params`: Provides defaults for the keyboard module parameters.

#### Class: `keyboard`

Main class, includes all other classes.

##### Parameters (all optional)

- `model`:
- `layout`:
- `variant`:
- `options`:
- `backspace`:
- `package`:
- `default_file`:

## Limitations

This module has been tested on the following systems:

* Debian
  * Wheezy
  * Jessie
* Ubuntu
  * 12.04
  * 14.04
  * 16.04

## Development

Should you have suggestions for improvements or issues with this module, please
report them on the [Github project][project-page].

Pull requests for extending support to other systems would be great!

[project-page]: https://github.com/danielsreichenbach/puppet_keyboard
