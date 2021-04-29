# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.56.56"
  # Packages installation
  config.vm.provision "shell", inline: <<-SOFTWARE
    echo "STEP: INSTALLING SOFTWARE"
    sleep 2
    yum update -y
    yum install vim tmux epel-release -y
    yum install nginx -y
    systemctl enable --now nginx
    SOFTWARE
  config.vm.provision "shell", inline: <<-SELINUX
    echo "STEP: SELINUX"
    sleep 2
    sed 's/SELINUX=enforcing/SELINUX=permissive/g' -i /etc/selinux/config
    setenforce 0
    SELINUX
  config.vm.provision "shell", run: "once", inline: <<-RSA
    echo "STEP: RSA"
    sleep 2
    mkdir -p /root/.ssh
    cat /vagrant/id_vagrant_rsa.pub >> /root/.ssh/authorized_keys
    cat /vagrant/id_vagrant_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
  RSA
  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
    v.name = "nginx"
  end
end
