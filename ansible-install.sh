#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

# copy examples into /home/vagrant (from inside the mgmt node)
cp -r /vagrant/frontend /home/vagrant
cp -r /vagrant/backend /home/vagrant
cp -r /vagrant/playbooks /home/vagrant
chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOF

# vagrant environment nodes
10.0.15.10  mgmt
10.0.15.12  db
10.0.15.11  lb
10.0.15.21  web1
10.0.15.22  web2
10.0.15.23  web3
10.0.15.24  web4
10.0.15.31  be1
10.0.15.32  be2
10.0.15.33  be3
10.0.15.34  be4
EOF

cat >> /home/vagrant/ansible.cfg << EOF
[defaults]
inventory=/home/vagrant/inventory.ini
EOF

cat >> /home/vagrant/inventory.ini << EOF
[lb]
lb

[web]
web1
web2
web3
web4

[backend]
be1
be2
be3
be4

[db]
db
EOF
