#!/bin/sh
# abort shell script in case any of the commands return a non-zero value
#set -e


env | sort

vault --version

kubectl version

which python3

python3 --version

HOSTNAME=$(hostname)
INVENTORY=hosts.txt
PLAYBOOK=playbook.yaml

cd /ansible

ansible-playbook -i ${INVENTORY} ${PLAYBOOK}
