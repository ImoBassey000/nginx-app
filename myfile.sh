#!/bin/bash
apt update -y
apt install -y ansible git
cd /home/ubuntu/ansible
ansible-playbook playbook.yml