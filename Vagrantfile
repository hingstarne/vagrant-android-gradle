# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # Puppet Labs Debian 7.0 for VirtualBox
  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box     = 'debian-70rc1-x64-vbox4210.box'
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box'
    virtualbox.customize ["modifyvm", :id, "--name", "tomcat6test"]
    virtualbox.customize ["modifyvm", :id, "--memory", "512"]
    virtualbox.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # Forward standard ports (local only, does not run under AWS)
  config.vm.network :forwarded_port, guest: 8080,  host: 8080, auto_correct: true
  config.vm.network :forwarded_port, guest: 8443, host: 8443, auto_correct: true

  # Install r10k using the shell provisioner and download the Puppet modules
  config.vm.provision :shell, :path => 'bootstrap.sh'

  # Puppet provisioner for primary configuration
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.options        = "--verbose --hiera_config /vagrant/hiera/hiera.yaml --modulepath /vagrant/modules"
  end
end
