vagrant-android-gradle
=====================

Generic Vagrant Powered Development Enviroment for Android
This is a headless environment just for building not for development

General notes
-------------
For the local install, we are using a box (image) from Puppet Labs (http://puppet-vagrant-boxes.puppetlabs.com/).

Puppet modules are pulled in using r10k on the VM.

Local install using VirtualBox
------------------------------
* Install VirtualBox
* Install Vagrant
* Checkout this repo
* Run: `vagrant up --provider virtualbox`

Based on the excellent work of the Harvard University
https://github.com/huit/vagrant-generic

