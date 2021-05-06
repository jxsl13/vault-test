#!/bin/bash


# VAULT_ADDR and VAULT_TOKEN
source scripts/env.sh

vault login "$VAULT_TOKEN"
