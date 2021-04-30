#!/bin/bash

function SOFTWARE (){
echo "STEP: INSTALLING SOFTWARE"
sleep 2
yum update -y
yum install vim tmux epel-release -y
yum install nginx -y
systemctl enable --now nginx
}

function HOSTNAME () {
echo "STEP: HOSTNAME"
hostnamectl set-hostname nginx.local
}

function SELINX () {
echo "STEP: SELINUX"
sleep 2
sed 's/SELINUX=enforcing/SELINUX=permissive/g' -i /etc/selinux/config
setenforce 0
}

function RSA () {
echo "STEP: RSA"
sleep 2
mkdir -p /root/.ssh
cat /vagrant/id_vagrant_rsa.pub >> /root/.ssh/authorized_keys
cat /vagrant/id_vagrant_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
}

function MKDIR () {
echo "STEP: MKDIR"
mkdir -p /sites/demo
/bin/cp -rf /vagrant/demo/ /sites/demo/
}



$1
