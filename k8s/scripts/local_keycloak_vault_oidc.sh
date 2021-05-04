#!/bin/bash


source scripts/env.sh

 
# login as reader
vault login -method=oidc role="reader" -format=json | jq -r '.auth.client_token' > ~/.vault-token


vault kv put secret/webapp/config oidc_reader="reader"


# login as manager
vault login -method=oidc role="manager" -format=json | jq -r '.auth.client_token' > ~/.vault-token

vault kv put secret/webapp/config oidc_manager="manager"



