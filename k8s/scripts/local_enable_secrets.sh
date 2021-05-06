#!/bin/bash


# source environment variables & login as root
source scripts/env.sh
source scripts/local_login.sh

# enable secrets
vault secrets enable -path=secret kv-v2 || true

