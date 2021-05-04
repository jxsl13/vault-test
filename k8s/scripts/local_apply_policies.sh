#!/bin/bash


# source environment variables
source scripts/env.sh


# write policies
vault policy write manager config/manager.hcl
vault policy write reader config/reader.hcl
