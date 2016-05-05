#!/bin/bash

#echo "192.168.100.201 node01.example.com" | tee -a /etc/hosts
sed -i /etc/hosts -e "s/node01.example.com node01/node01/g"
mkdir /root/.ssh 2> /dev/null
cat /vagrant/id_rsa.pub >> /root/.ssh/authorized_keys
