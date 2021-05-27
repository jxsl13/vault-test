# Ansible playbook that deploys Hashicorp Vault

# Summary

This playbook deploys the HashiCorp Vault as well as HashiCorp Consul helm charts to your kubernetes cluster that is pointed at by your `~/.kube/config` file.
This file can be changes to any other file that is in your `~/.kube/` directory by adjusting the values in `stages/host_vars/localhost.yaml`
The playbook creates a vault namespace if neccessary.
The name of the release as well as the target namespace can be changed in the same `localhost.yaml` file.
You get three Vault pods for high availability (not configurable).

Afterwards your vault is initialized and unsealed and the root token as well as the unseal keys are saved in `stages/secrets/clluster_keys.json`

Then these stages are run:
    - apply all policies found under `stages/policies` the filenames define the policy name
    - configure JWT and enforce policy ACL mapping, meaning, if your Keycloak user does not have the same client role as the <policy>.hcl, they are not granted that policy access when trying to login with the role <policy>
    - the same happens with the OIDC role mapping. Your user tries to login with a role which is the policy name. Vault checks their client roles in order to grant access with the corresponding policy.
    - afterwards an internal group is created for every policy file with the corresponding name of the file without the hcl extension.
    - the secrets engine is configured and enabled. An example secret is the created.
    - the PKI engine is configured (and certificates are imported) and a role is created for every HCL policy that contains pki (case insensitive) in its file name.
    - the SSH engine is configured and the root public/private keys are imported. Also a role is created for every hcl policy that contains ssh (case insensitive).


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
Open the file `cd stages/secrets && mv keycloak.yaml.example keycloak.yaml && vi keycloak.yaml && cd ../..`

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