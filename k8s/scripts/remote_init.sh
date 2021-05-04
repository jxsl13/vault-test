#!/bin/bash

kubectl exec --namespace vault vault-0 -- /bin/sh -c "vault operator init -key-shares=1 -key-threshold=1 -format=json" > secrets/cluster-keys.json