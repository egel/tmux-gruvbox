# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # config.vm.box = "hashicorp/bionic64"
  # config.vm.box = "ubuntu/jammy64"
  # config.vm.box_version = "1.0.282"
  config.vm.box = "teak/bullseye_arm64"

  config.vm.provider "virtualbox" do |vb|
    # display the virtualbox gui when booting the machine
    vb.gui = true

    # customize the amount of memory on the vm:
    vb.memory = "1024"

    # custom CPU
    vb.cpus = 6
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y tmux git
  SHELL
end
