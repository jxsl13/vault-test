#!/bin/bash

# source environment variables & login as root
source scripts/env.sh
source scripts/local_login.sh

DISCOVERY_URL="$KEYCLOAK_URL/realms/$REALM"


# OIDC configuration
vault write auth/oidc/config \
    default_role="reader" \
    bound_issuer="$DISCOVERY_URL" \
    oidc_discovery_url="$DISCOVERY_URL" \
    oidc_client_id="$CLIENT_ID" \
    oidc_client_secret="$CLIENT_SECRET"


# reader role
vault write auth/oidc/role/reader -<<EOF
{
  "user_claim": "sub",
  "role_type": "oidc",
  "bound_audiences": "$CLIENT_ID",
  "policies": "reader",
  "ttl": "1h",
  "groups_claim": "/resource_access/$CLIENT_ID/roles",
  "bound_claims": { "/resource_access/$CLIENT_ID/roles": ["reader"] },
  "verbose_oidc_logging": true,
  "allowed_redirect_uris": ["http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback", "http://localhost:8200/ui/vault/auth/oidc/oidc/callback"]
}
EOF
vault read auth/oidc/role/reader


# manager role
vault write auth/oidc/role/manager -<<EOF
{
  "user_claim": "sub",
  "role_type": "oidc",
  "bound_audiences": "$CLIENT_ID",
  "policies": "manager",
  "ttl": "1h",
  "groups_claim": "/resource_access/$CLIENT_ID/roles",
  "bound_claims": { "/resource_access/$CLIENT_ID/roles": ["manager"] },
  "verbose_oidc_logging": true,
  "allowed_redirect_uris": ["http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback", "http://localhost:8200/ui/vault/auth/oidc/oidc/callback"]
}
EOF

vault read auth/oidc/role/manager
