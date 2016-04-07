source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :unit_tests do
  gem 'rake',                    :require => false
  gem 'rspec-core',              :require => false
  gem 'rspec-puppet',            :require => false
  gem 'puppetlabs_spec_helper',  :require => 'puppetlabs_spec_helper/rake_tasks'
  gem 'puppet-lint',             :require => 'puppet-lint/tasks/puppet-lint'
  gem 'simplecov',               :require => false
  gem 'puppet_facts',            :require => false
  gem 'json',                    :require => false
end

group :system_tests do
  gem 'beaker-rspec', :require => false
  gem 'pry', :require => false
end

if RUBY_VERSION != '1.8.7'
  gem 'puppet-blacksmith', :require => 'puppet_blacksmith/rake_tasks'
end

if facterversion = ENV['FACTER_GEM_VERSION']
    gem 'facter', facterversion, :require => false
else
    gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
    gem 'puppet', puppetversion, :require => false
else
    gem 'puppet', :require => false
end

