#!/bin/bash
apt update -y
apt install -y ansible git
git clone https://github.com/ImoBassey000/nginx-app/ansible-playbook.git /home/ubuntu/ansible
cd /home/ubuntu/ansible
ansible-playbook playbook.yml
