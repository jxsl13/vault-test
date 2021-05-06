#!/bin/bash


# source environment variables & login as root user
source scripts/env.sh
source scripts/local_login.sh

# write policies
vault policy write manager config/manager.hcl
vault policy write reader config/reader.hcl
