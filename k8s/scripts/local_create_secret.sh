#!/bin/bash


source scripts/env.sh



vault kv put secret/webapp/config username="static-user" password="static-password"
