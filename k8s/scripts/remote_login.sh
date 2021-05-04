#!/bin/bash

# VAULT_ADDR and VAULT_TOKEN
source scripts/env.sh

kubectl exec --namespace vault vault-0 -- vault login "$VAULT_TOKEN"
kubectl exec -it --namespace vault vault-0 -- /bin/sh
