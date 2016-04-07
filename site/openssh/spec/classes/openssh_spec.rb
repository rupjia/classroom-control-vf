require 'spec_helper'
describe 'openssh', :type => :class do

  context 'with defaults for all parameters on RedHat' do
    let (:facts) {{
      :osfamily => 'RedHat',
      :ipaddress => '10.10.10.10',
    }}

    it do
      should contain_class('openssh')
      should contain_class('openssh::params')
      should contain_class('openssh::install')
      should contain_class('openssh::config').that_requires('Class[openssh::install]')
      should contain_class('openssh::service').that_subscribes_to('Class[openssh::config]')
    end
  end

end

# report code coverage
at_exit { RSpec::Puppet::Coverage.report! }
