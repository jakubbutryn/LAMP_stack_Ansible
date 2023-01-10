#!/bin/bash

apt-get update
apt-get install -y ansible

mkdir lamp_playbook
cp lamp_playbook.yml lamp_playbook/


echo "xx.xx.xx.xx" > lamp_playbook/lamp_servers


cat >> lamp_playbook/lamp_playbook.yml <<EOF
  - name: Install additional PHP modules
    package:
      name:
        - php-xml
        - php-mysql
      state: present
EOF


cat >> lamp_playbook/lamp_playbook.yml <<EOF
  - name: Configure firewall
    ufw:
      rule: allow
      port: "{{ apache_port }}"
EOF


ansible-playbook -i lamp_playbook/lamp_servers lamp_playbook/lamp_playbook.yml
