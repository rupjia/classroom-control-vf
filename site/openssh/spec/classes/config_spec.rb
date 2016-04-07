require 'spec_helper'
describe 'openssh', :type => :class do

  context 'should change default and given parameters' do
    let (:facts) {{
      :osfamily => 'RedHat',
      :ipaddress => '10.10.10.10',
    }}
    let (:params) { {
      :config => {
        'foo' => 'bar'
      }
    } }
    it do
      should contain_augeas('sshd_config').with({
        :context => '/files/etc/ssh/sshd_config',
        :changes => [
          'set PermitRootLogin "no"',
          'set foo "bar"',
	]
      })
    end
  end

  context 'should change given parameters and allow changing of default parameters' do
    let (:facts) {{
      :osfamily => 'RedHat',
      :ipaddress => '10.10.10.10',
    }}
    let (:params) { {
      :sshd_config => '/foobar',
      :config => {
        'PermitRootLogin' => 'YES',
        'foo' => 'bar'
      }
    } }
    it do
      should contain_augeas('sshd_config').with({
        :context => '/files/foobar',
        :changes => [
          'set PermitRootLogin "YES"',
          'set foo "bar"',
	]
      })
    end
  end

end
