# set parameters for openssh class
class openssh::params {

  # fail for unsupported osfamilies
  $supported_osfamilies = [ 'RedHat', 'Debian' ]
  if ! ($::osfamily in $supported_osfamilies) {
    fail("Unsupported osfamily ${::osfamily}")
  }

  # module specific parameters
  $ensure      = 'present'
  $exporttag   = 'managedhosts'
  $collecttag  = 'managedhosts'

  # osfamily-specific parameters
  $packages = $::osfamily ? {
    'RedHat' => [ 'openssh-server', 'openssh-clients' ],
    'Debian' => [ 'openssh-server', 'openssh-client' ],
    default  => '',
  }
  $servicename = $::osfamily ? {
    'RedHat' => 'sshd',
    'Debian' => 'ssh',
    default  => '',
  }
  $sshd_config = '/etc/ssh/sshd_config'

  # default sshd_config parameters
  $sshd_config_def = {
    'PermitRootLogin' => 'no',
  }
  $config = {}
}
