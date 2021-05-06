#!/bin/bash

kubectl create namespace vault

helm install consul hashicorp/consul --namespace vault --values values/consul-vault-values.yaml
helm install vault  hashicorp/vault --namespace vault --values values/vault-values.yaml

echo "Waiting for the deployment to startup..."
kubectl rollout status daemonset.apps/consul-consul --timeout=60s -n vault | grep 'daemon set \"consul-consul\" successfully rolled out'
sleep 5
