Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.56.56"
  # Packages installation
  config.vm.provision "shell", inline: <<-SOFTWARE
    yum update -y
    yum install vim tmux epel-release -y
    yum install nginx -y
    systemctl enable --now nginx
    SOFTWARE
  config.vm.provision "shell", inline: <<-SSH
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIJp/R4Ecksf2qhIGKb9lmFKGO8yetEjpIDq3l83ML+kG6z7/03e4AEcwLkj+7bRVUsCJdXmBCMaxhOyvImmrxJTl+nPs2SHPBkidt1eonbW+7Doam8q7o1wV3tnISPEivd0vZDoq3R5CDNa7Tr7PCvA1ZtZtxc8Bt0P59rV6iVs5ensQQkN/iGV4XdCEwenCZBsSN41rnSpDLF4GbKC2p02AazNJNyECK2WxLIIVSgxnlrDEcwjkGgbkdlQSR94bTWf1cmLEJoNxqqLtUH5NDcz3Qks7GBxjwpKiRzsuK2T9Xa0ETnIsJviM31xHciW00skX8ffupr5m+EBWheuBc2VdFparc6Yw1I5okPaxdQeCBRBS6UHm63BRtDdIabFg621zehQjsw0aylI/jMlWJJ3rbuw+P3s8DRM57v72CChmT5nvX7DK+qAlbIFFRefDG84wZ54QQUks4CxUa81Nn+qEKCf/UcIQ1RsTJ5lWF7Pu6AseMZW7Gcxg6zjtDPzE= grzegorz@DELL" >> /home/vagrant/.ssh/authorized_keys
    mkdir -p /root/.ssh/
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIJp/R4Ecksf2qhIGKb9lmFKGO8yetEjpIDq3l83ML+kG6z7/03e4AEcwLkj+7bRVUsCJdXmBCMaxhOyvImmrxJTl+nPs2SHPBkidt1eonbW+7Doam8q7o1wV3tnISPEivd0vZDoq3R5CDNa7Tr7PCvA1ZtZtxc8Bt0P59rV6iVs5ensQQkN/iGV4XdCEwenCZBsSN41rnSpDLF4GbKC2p02AazNJNyECK2WxLIIVSgxnlrDEcwjkGgbkdlQSR94bTWf1cmLEJoNxqqLtUH5NDcz3Qks7GBxjwpKiRzsuK2T9Xa0ETnIsJviM31xHciW00skX8ffupr5m+EBWheuBc2VdFparc6Yw1I5okPaxdQeCBRBS6UHm63BRtDdIabFg621zehQjsw0aylI/jMlWJJ3rbuw+P3s8DRM57v72CChmT5nvX7DK+qAlbIFFRefDG84wZ54QQUks4CxUa81Nn+qEKCf/UcIQ1RsTJ5lWF7Pu6AseMZW7Gcxg6zjtDPzE= grzegorz@DELL" >> /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    SSH
  config.vm.provision "shell", inline: <<-SELINUX
    sed 's/SELINUX=enforcing/SELINUX=permissive/g' -i /etc/selinux/config
    setenforce 0
    SELINUX
  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
    v.name = "nginx"
  end
end
