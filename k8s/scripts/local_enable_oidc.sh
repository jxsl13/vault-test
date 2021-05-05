#!/bin/bash


# source environment variables
source scripts/env.sh

# enable oidc
vault auth enable oidc || true
