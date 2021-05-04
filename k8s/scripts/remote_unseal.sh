#!/bin/bash


VAULT_UNSEAL_KEY=$(cat secrets/cluster-keys.json | jq -r ".unseal_keys_b64[]")

kubectl exec --namespace vault vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl exec --namespace vault vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl exec --namespace vault vault-2 -- vault operator unseal $VAULT_UNSEAL_KEY

