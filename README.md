# ansible playbook in order to provision HashiCorp Vault in a Kubernetes Environment

# info
[hashi vault module](https://terryhowe.github.io/ansible-modules-hashivault/modules/list_of_hashivault_modules.html)

[SSH CA tutorial - 1](https://www.lorier.net/docs/ssh-ca.html)
[SSH CA tutorial - 2](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sec-using_openssh_certificate_authentication)

## Requirements

- docker
- docker-compose
- kubectl

# Setup

### Generate certificates and private/public keys
Execute `cd stages/secrets && make && cd ../..` in order to create certificates and private & public keys.

### Configure Keycloak
Open the file `cd stages/secrets && mv keycloak.yaml.example keycloak.yaml && vi stages/secrets/keycloak.yaml && cd ../..`

### Deploy Vault (error expected)
Execute `make` for the first time. This will deploy the vault in the vault namespace
You will encounter a long error stating that it cannot execute the next step, as you do not have any port forwarding setup, nor does Ansible know the VAULT_ADDR of your vault.

### Port forward vault to localhost host system
Execute `make port-forward`

### Final configuration
Execute `make` a second time after your have established a port forward to your vault.


## TODO:
    - Keycloak is only filled with configuration data, this Playbook just takes an existing keycloak and fills it with the corresponding data
    - (Keycloak Ansible plugin)[https://docs.ansible.com/ansible/latest/collections/community/general/keycloak_client_module.html]