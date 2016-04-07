require 'spec_helper_acceptance'

describe 'openssh class' do

  context 'with defaults' do
    it 'should run without errors' do
      pp = <<-EOS
        class { 'openssh': ; }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/etc/ssh/sshd_config') do
      its(:content) { should match(/PermitRootLogin no/) }
    end

    describe process('sshd') do
      it { should be_running }
    end

    describe port(22) do
      it { should be_listening }
    end

  end

  context 'on RedHat', :if => fact('osfamily').eql?('RedHat') do
    describe package('openssh-server') do
      it { should be_installed }
    end
    describe package('openssh-clients') do
      it { should be_installed }
    end
  end

  context 'on Debian', :if => fact('osfamily').eql?('Debian') do
    describe package('openssh-server') do
      it { should be_installed.by('apt') }
    end
    describe package('openssh-client') do
      it { should be_installed.by('apt') }
    end
  end

  context 'with some usual parameters' do
    it 'should run without errors' do
      pp = <<-EOS
        class { 'openssh':
          config => {
            'GSSAPIAuthentication'     => 'yes',
            'GSSAPICleanupCredentials' => 'yes',
            'X11Forwarding'            => 'no',
            'AllowTcpForwarding'       => 'no',
          },
          exporttag  => false,
          collecttag => false,
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/etc/ssh/sshd_config') do
      its(:content) { should match(/GSSAPIAuthentication yes/) }
      its(:content) { should match(/GSSAPICleanupCredentials yes/) }
      its(:content) { should match(/X11Forwarding no/) }
      its(:content) { should match(/AllowTcpForwarding no/) }
    end

  end


  context 'with non-default port configuration' do
    it 'should run without errors' do
      pp = <<-EOS
        class { 'openssh':
          config => {
            'Port[1]'     => '22',
            'Port[2]'     => '222',
          },
          exporttag  => false,
          collecttag => false,
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/etc/ssh/sshd_config') do
      its(:content) { should match(/Port 22/) }
      its(:content) { should match(/Port 222/) }
    end

    describe process('sshd') do
      it { should be_running }
    end

    describe port(22) do
      it { should be_listening }
    end
    describe port(222) do
      it { should be_listening }
    end

  end

end
