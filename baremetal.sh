#!/bin/bash
# Install puppet
wget http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb -O /tmp/puppet.deb
dpkg -i /tmp/puppet.deb
# Update repository
apt-get -q update

# Install R10K dependencies
apt-get install -y -q git ruby1.9.1 puppet

if [[ "$(gem query -i -n r10k)" == "false" ]]; then
  gem install --no-rdoc --no-ri r10k
fi

git clone git@gitlab.ai.ar.tum.de:itops/vagrant_ruby_dev.git /vagrant

# Build Puppet environment from Puppetfile
cd /vagrant && r10k puppetfile install
puppet apply --verbose --hiera_config /vagrant/hiera/hiera.yaml --modulepath /vagrant/modules /vagrant/manifests/init.pp
sleep 5
