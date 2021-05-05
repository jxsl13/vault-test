

# HashiCorp Vault Test

This is an example configuration of HashiCorp Vault that interacts with a Keycloak Identity Provider. 
Contrary to the OIDC workflow that requires the user to interact with a web browser, we do want to use Vault for automated workflows that solely require a JSON Web Token.

This setup is a boilerplate for such a potential workflow. 

## Keycloak Setup

[ ] [Enable client role mapping into id_token](https://issues.redhat.com/browse/KEYCLOAK-3027) [Alternative tutorial](https://number1.co.za/using-keycloak-as-the-identifyprovider-to-login-to-hashicorp-vault/)


## Requirements
- *jq* CLI tool
- *curl* CLI tool
- *vault* HashiCorp's Vault cli installed locally


Use the native terminal of your linux system, the VS Code terminal is broken.
```
cd k8s

make

```

## Structure

```
Makefile -> make.sh -> scripts/*.sh                    -> scripts/env.sh -> secrets/vault.env
                    -> scripts/local_apply_policies.sh -> config/*.hcl
```