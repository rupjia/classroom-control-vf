# openssh::config: Cares about the whole openssh-configuration including
# rollout of known hostkeys
class openssh::config {

  # just in case you need special settings for some class parameters you can
  # fill this hash
  $override = {}

  # merge defaults and config - defined defaults get overridden, and
  # user-config gets overridden by $override
  $merged_config = merge($::openssh::sshd_config_def, $::openssh::config,
  $override)

  # build an array from the config-hash for the augeas resource
  $separated_config = inline_template('<% @merged_config.each do
  |name_and_options| -%>set <%= name_and_options[0] %> "<%= name_and_options[1]
  %>",<% end -%>')
  $config_array = split( chop( $separated_config ), ',')

  augeas { 'sshd_config':
    context => "/files${openssh::sshd_config}",
    changes => $config_array,
  }


  # Key management

  # export keys
  if $::openssh::exporttag {
    # key must not be exported if they are empty. This is the case in the
    # puppet run where openssh gets installed as facter runs before openssh is
    # installed and for that can't gather the keys. Otherwise puppet will
    # throw an error that 'key' may not be empty.
    case $::sshecdsakey {
      '': { warning('Did not export sshkey, because it\'s empty!') }
      default: {
        @@sshkey { $::fqdn:
          ensure => present,
          type   => 'ecdsa-sha2-nistp256',
          key    => $::sshecdsakey,
          tag    => $::openssh::exporttag,
        }

        @@sshkey { $::ipaddress:
          ensure => present,
          type   => 'ecdsa-sha2-nistp256',
          key    => $::sshecdsakey,
          tag    => $::openssh::exporttag,
        }
      }
    }
  }

  # collect keys
  if $::openssh::collecttag {
    Sshkey <<| tag == $::openssh::collecttag |>>
  }

}
