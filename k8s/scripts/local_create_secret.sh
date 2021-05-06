#!/bin/bash

# source environment variables an dlogin as root user
source scripts/env.sh
source scripts/local_login.sh

# create some secret
vault kv put secret/webapp/config username="static-user" password="static-password"
