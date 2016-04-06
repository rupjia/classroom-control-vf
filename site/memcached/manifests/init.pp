class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { 'memcached_config':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    suscribe => File['memcached_config']
  }
}
