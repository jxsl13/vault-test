#!/bin/bash

kubectl exec --namespace vault vault-0 -- /bin/sh -c "rm ~/.vault-token"