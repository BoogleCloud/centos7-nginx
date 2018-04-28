# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  config.vm.hostname = "centos7-nginx"
  config.vm.define "centos7-nginx"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.network "public_network", bridge: "langrill.local"
  
  config.vm.provider "hyperv" do |h|
    h.vmname = "centos7-nginx"
    h.differencing_disk = true
    h.vlan_id = 5
    h.cpus = 2
    h.memory = 1024
  end

  config.vm.provision "resources", type: "file", source: "resources", destination: "/tmp/resources"
  config.vm.provision "bootstrap", type: "shell", path: "bootstrap-rhel.sh"
  config.vm.provision :reload
  config.vm.provision "index.html", type: "file", source: "index.html", destination: "/tmp/index.html"
  config.vm.provision "nginx-setup", type: "shell", path: "nginx-setup-rhel.sh"
end
