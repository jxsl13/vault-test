#!/bin/bash


echo "Killing kubectl port forward"
kill $(ps aux | grep '[k]ubectl port-forward' | awk '{print $2}')

helm uninstall consul --namespace vault

helm uninstall vault --namespace vault

kubectl delete namespace vault