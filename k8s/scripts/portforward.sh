#!/bin/bash


xterm -hold -e 'kubectl port-forward --namespace vault vault-0 8200:8200' &

sleep 5
