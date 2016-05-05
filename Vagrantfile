# -*- mode: ruby -*-
# vi: set ft=ruby :

public_network_interface="eno1"


Vagrant.configure(2) do |config|
  
  #https://github.com/dotless-de/vagrant-vbguest
  unless Vagrant.has_plugin?("vagrant-hostmanager")
    raise "please install the vagrant-hostmanager plugin"
  end
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true

  #https://github.com/dotless-de/vagrant-vbguest
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
  end

  #config.vm.box = "centos-7-with-vbguest.box"
  config.vm.box = "bento/centos-7.2"

  config.vm.provider "virtualbox" do |vbox, override|
    vbox.linked_clone = true
    vbox.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.define "node01" do |node|

    node.vm.hostname = "node01.example.com"
    node.vm.network :private_network, ip: "192.168.100.201"
    node.vm.network :public_network, bridge: public_network_interface
    
    node.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2
    end
    
    node.vm.provision :shell, :path => "provision-node.sh"
  end

  config.vm.define :admin do |node|
    
    node.vm.hostname = "admin"
    node.vm.network :private_network, ip: "192.168.100.101"
    node.vm.network :public_network, bridge: public_network_interface

    node.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end

    node.vm.provision :shell, :path => "provision-admin.sh"
  end

end
