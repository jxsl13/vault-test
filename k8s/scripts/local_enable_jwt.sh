#!/bin/bash


# source environment variables & login as root
source scripts/env.sh
source scripts/local_login.sh

# enable jwt
vault auth enable jwt || true
