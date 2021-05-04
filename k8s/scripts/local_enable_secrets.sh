#!/bin/bash


# source environment variables
source scripts/env.sh

# enable secrets

vault secrets enable -path=secret kv-v2 || true

