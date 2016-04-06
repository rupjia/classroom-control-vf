class nginx {
  package { 'nginx':
    ensure => installed,
  }
  file { '/var/www':
    ensure  => directory,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
  file { '/var/www/index.html':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/nginx/index.html'
  }

  file { '/etc/nxinx/nginx.config':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/nginx/default.config',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  file { '/etc/nginx/conf.d':
    ensure  => directory,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
  file { '/etc/nginx/conf.d/default.config':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/nginx/default.config',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  service { 'name':
    ensure => running,
    enable => true,
  }
}
