require 'spec_helper'
describe 'openssh', :type => :class do

  context 'with defaults for all parameters on unsupported osfamily' do
  let (:facts) { {:osfamily => 'Foo'} }
    it do
      expect {
        should contain_class('openssh')
      }.to raise_error(Puppet::Error, /Unsupported osfamily Foo/)
    end
  end

end
