# ansible playbook in order to provision HashiCorp Vault in a Kubernetes Environment

# info

[hashi vault module](https://terryhowe.github.io/ansible-modules-hashivault/modules/list_of_hashivault_modules.html)


## Requirements

- *kubectl* must be installed on your control node (where ansible connects to, in this case it's localhost)
- [Install ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu)
- openssl

Install the Kubernetes module for ansible
```
make requirements
```
