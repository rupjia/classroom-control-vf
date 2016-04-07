# openssh::install: Installs the packages on the system
class openssh::install {

  package { $openssh::packages:
    ensure => $openssh::ensure,
  }

}
