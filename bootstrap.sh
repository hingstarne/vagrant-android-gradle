#!/bin/bash

# Update repository
apt-get -q update

# Install R10K dependencies
apt-get install -y -q git ruby1.9.1

if [[ "$(gem query -i -n r10k)" == "false" ]]; then
  gem install --no-rdoc --no-ri r10k
fi

# Build Puppet environment from Puppetfile
cd /vagrant && r10k puppetfile install
sleep 5
