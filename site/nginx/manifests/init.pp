class nginx (
  $root = '/var/www'
){
  $nginx = 'nginx'
  $docroot = "${root}/index.html"
  $index_src = "puppet:///modules/${nginx}/index.html"
  $nginx_conf_src = "puppet:///modules/${nginx}/nginx.conf"
  $nginx_default_scr = "puppet:///modules/${nginx}/default.conf"

  File {
    owner => 'root',
    group => 'root',
    mode => '0664',
  }
  package { $nginx:
    ensure => present,
  }
  file { [ $root, '/etc/nginx/conf.d' ]:
    ensure => directory,
  }
  file { $docroot:
    ensure => file,
    source => $index_src,
  }
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => $nginx_conf_src,
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => $nginx_default_scr,
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  service { $nginx:
    ensure => running,
    enable => true,
  }
}
