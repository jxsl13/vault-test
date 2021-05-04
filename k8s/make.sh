#!/bin/bash


echo "# Installing vault..."
source scripts/remote_install_vault.sh

echo "# Initializing vault..."
source scripts/remote_init.sh

echo "# Fetching environment varibales"
source scripts/env.sh

echo "# Unsealing vaults..."
source scripts/remote_unseal.sh

echo "# Port forwarding in new terminal.."
source scripts/portforward.sh

echo "# Logging in locally..."
source scripts/local_login.sh

echo "# Applying policies"
source scripts/local_apply_policies.sh

echo "# Enabling JWT"
source scripts/local_enable_jwt.sh

echo "# Configure JWT"
source scripts/local_configure_jwt.sh

echo "# Enable secrets"
source scripts/local_enable_secrets.sh

echo "# Create secret"
source scripts/local_create_secret.sh

echo "# Login via Keycloak"
source scripts/local_keycloak_vault_login.sh

