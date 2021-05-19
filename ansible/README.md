# ansible playbook in order to provision HashiCorp Vault in a Kubernetes Environment

# info

[hashi vault module](https://terryhowe.github.io/ansible-modules-hashivault/modules/list_of_hashivault_modules.html)

[SSH CA tutorial - 1](https://www.lorier.net/docs/ssh-ca.html)
[SSH CA tutorial - 2](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sec-using_openssh_certificate_authentication)

## Requirements

- *kubectl* must be installed on your control node (where ansible connects to, in this case it's localhost)
- [Install ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu)
- openssl
- python

Install the Kubernetes module for ansible
```
make requirements
```


## TODO:
    - Keycloak is only filled with configuration data, this Playbook just takes an existing keycloak and fills it with the corresponding data
    - (Keycloak Ansible plugin)[https://docs.ansible.com/ansible/latest/collections/community/general/keycloak_client_module.html]