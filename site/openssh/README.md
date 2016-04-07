# openssh
[![Build Status](https://travis-ci.org/fonk/fonk-openssh.svg?branch=master)](https://travis-ci.org/fonk/fonk-openssh)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with openssh](#setup)
    * [What openssh affects](#what-openssh-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with openssh](#beginning-with-openssh)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Module to manage OpenSSH with focus on using augeas for configfile modifications
to provide compatibility with upstream changes in this files.

Puppetversion: >= 3.5.0

OS: RedHat, Debian

## Module Description

This Module installs the openssh server and client and manages the sshd\_config.
It optionally gathers the hostkeys and provides them for other hosts.

## Setup

### What openssh affects

* Packages and service for openssh
* sshd\_config
* system-wide known\_hosts file

### Setup Requirements

To use spreading of hostkeys you will need a puppetdb-enabled puppetserver

### Beginning with openssh

To begin using this module with default parameters, declare the class with
`include openssh`

Any Puppet code that uses anything from the apt module requires that the core
apt class be declared.

## Usage

### Simple usage
Install packages, set some defaults, ensure service is running, export all keys
to all hosts

    class { 'openssh': }

### Advanced usage
Because the hash of the config-parameter gets passed comletely to augeas, you
can use all options your augeas lens provides in the way your augeas lens
specifies it. Here are some examples for that:

Install packages, set some custom values, ensure service is running, export and
collect no keys

    class { '::openssh':
      config => {
        'X11Forwarding'      => 'no',
        'AllowTcpForwarding' => 'yes',
        'Port'               => '222',
      },
      exporttag  => false,
      collecttag => false,
    }

### Even more advanced usage
Install packages, set two listening ports and special parameters for group "no-admin", ensure service is running, export
keys with tag "customer\_hosts" and collect no keys

    class { '::openssh':
      config => {
        'X11Forwarding' => 'no',
        'AllowTcpForwarding' => 'yes',
        'Port[1]'            => '222',
        'Port[2]'            => '333',
        'Match[1]/Condition/Group'          => 'no-admin',
        'Match[1]/Settings/ChrootDirectory' => '/home',
        'Match[1]/Settings/X11Forwarding'   => 'no',
      },
      exporttag  => 'customer_hosts',
      collecttag => false,
    }

## Reference

### Classes

* `openssh`: Main class that is used to set the variables and includes the other classes

* `openssh::params`: Sets defaults for the variables used by this module

* `openssh::install`: Installs the packages on the system

* `openssh::config`: Cares about the whole openssh-configuration including rollout of known hostkeys

* `openssh::service`: Handles the openssh service

### Parameters

#### openssh
* `ensure`: Set the ensure-value for the packages.
  Default: 'present'

* `packages`: Name or array of the packages to be installed.
  Default: osfamily-specific (see params.pp)

* `servicename`: Name of the service to be started
  Default: osfamily-specific (see params.pp)

* `sshd_config`: Path to the sshd\_config file
  Default: /etc/ssh/sshd\_config

* `sshd_config_def`: Default values for sshd\_config parameters. This should almost never need to be changed.

* `config`: A hash with all options that should get set in sshd\_config

* `exporttag`: Tag that the exported hostkey get for collecting. If 'false', key won't get exported.
  Default: managedhosts

* `collecttag`: Keys with this tag will get collected. If 'false', keys won't get collected.

## Limitations

## Development

If you like to contribute: pull requests are welcome :-)
