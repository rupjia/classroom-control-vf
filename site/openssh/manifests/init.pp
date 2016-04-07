# == Class: openssh
#
# This class installs and configures openssh
#
# === Parameters
#
# see README.md
#
# === Examples
#
#  class { 'openssh': }
#
# === Authors
#
# Frank Grötzner <frank@unforgotten.de>
#
# === Copyright
#
# Copyright 2015 Frank Grötzner, unless otherwise noted.
#
class openssh (
  $ensure          = $openssh::params::ensure,
  $packages        = $openssh::params::packages,
  $servicename     = $openssh::params::servicename,
  $config          = $openssh::params::config,
  $sshd_config     = $openssh::params::sshd_config,
  $sshd_config_def = $openssh::params::sshd_config_def,
  $exporttag       = $openssh::params::exporttag,
  $collecttag      = $openssh::params::collecttag,
) inherits openssh::params {

  class { '::openssh::install': ; } ->
  class { '::openssh::config': ; } ~>
  class { '::openssh::service': ; }

  contain '::openssh::install'
  contain '::openssh::config'
  contain '::openssh::service'

}
