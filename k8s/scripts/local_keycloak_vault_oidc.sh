#!/bin/bash


source scripts/env.sh

# login as reader
#vault login -method=oidc role="reader" -format=json | jq -r '.auth.client_token' > ~/.vault-token

# login as manager
#vault login -method=oidc role="manager" -format=json | jq -r '.auth.client_token' > ~/.vault-token


firefox localhost:8200
 



