#!/bin/bash

#echo "192.168.100.201 node01.example.com" | tee -a /etc/hosts

mkdir /root/.ssh 2> /dev/null
cat /vagrant/id_rsa.pub >> /root/.ssh/authorized_keys
cp /vagrant/id_rsa* /root/.ssh
ssh-keyscan -H node01 node01.example.com >> ~/.ssh/known_hosts 2>/dev/null

yum -y install git net-tools

# install prerequisites to run ansible
yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
yum -y --enablerepo=epel install ansible1.9-1.9.4-2.el7 pyOpenSSL

#https://github.com/openshift/openshift-ansible/blob/master/README_origin.md
cd /root
git clone https://github.com/openshift/openshift-ansible

cd openshift-ansible
ansible-playbook -i /vagrant/hosts playbooks/byo/config.yml