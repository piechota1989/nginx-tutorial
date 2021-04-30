# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.56.56"
  # Packages installation
  config.vm.provision "shell", path: "provision.sh", args: "SOFTWARE"
  config.vm.provision "shell", path: "provision.sh", args: "HOSTNAME"
  config.vm.provision "shell", path: "provision.sh", args: "SELINX"
  config.vm.provision "shell", path: "provision.sh", args: "RSA"
  config.vm.provision "shell", path: "provision.sh", args: "MKDIR"
  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
    v.name = "nginx"
  end
end
