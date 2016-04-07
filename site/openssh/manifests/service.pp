# openssh::service: Handles the openssh service
class openssh::service {

  # ensure the service is enabled and running
  service { $::openssh::servicename:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

}
