

# HashiCorp Vault Test

This is an example configuration of HashiCorp Vault that interacts with a Keycloak Identity Provider. 
Contrary to the OIDC workflow that requires the user to interact with a web browser, we do want to use Vault for automated workflows that solely require a JSON Web Token.

This installation configures the OIDC as well as the JWT authorization workflow. 

As well as two roles that each have different 

This setup is a boilerplate for such a potential workflow. 

## Good to know
- [external groups may only have one alias](https://discuss.hashicorp.com/t/creating-group-aliases-does-not-create-them/24098)


## Requirements

### Keycloak
- create a client and allow it to redirect to your vault url. In case yo are using a local setup, provide both urls
    - http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback
    - http://localhost:8200/ui/vault/auth/oidc/oidc/callback
- in case you have a local keycloak setup, you  might want to use `ngrok http 8091` to expose your local keycloak with a randomly generated subdomain of [ngrok.io](https://ngrok.io)
- create two users, a *vault_manager* and a *vault_reader*, 
- create client roles *reader* and *manager*
- enable [client role mapping into id_token](https://number1.co.za/using-keycloak-as-the-identifyprovider-to-login-to-hashicorp-vault/) so that the id token contains the *resource_access* claim containing the corresponsing client id as well as the user role.
- set ssl requirements to *none* in your realm settings 

### Local environment
- *kubectl*/kubernetes/Minikube running
- *helm* installed
- *jq* CLI tool
- *curl* CLI tool
- *vault* HashiCorp's Vault cli installed locally
- Provide all of the necessary environment variables in `secrets/vault.sample` and rename the file to `secrets/vault.env`


## Deployment

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