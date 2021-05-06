#!/bin/bash


# source environment variables & login as root user
source scripts/env.sh
source scripts/local_login.sh

DISCOVERY_URL="$KEYCLOAK_URL/realms/$REALM"
JWKS_URL="$KEYCLOAK_URL/realms/$REALM/protocol/openid-connect/certs"


# configure JWT auth method
vault write auth/jwt/config \
    default_role="reader" \
    bound_issuer="$DISCOVERY_URL" \
    jwks_url="$JWKS_URL"


# create reader role
vault write auth/jwt/role/reader -<<EOF
{
  "user_claim": "sub",
  "role_type": "jwt",
  "bound_audiences": "$CLIENT_ID",
  "policies": "reader",
  "ttl": "1h",
  "groups_claim": "/resource_access/$CLIENT_ID/roles",
  "bound_claims": { "/resource_access/$CLIENT_ID/roles": ["reader"] },
  "verbose_oidc_logging": true
}
EOF

vault read auth/jwt/role/reader


# create manager role
vault write auth/jwt/role/manager -<<EOF
{
  "user_claim": "sub",
  "role_type": "jwt",
  "bound_audiences": "$CLIENT_ID",
  "policies": "manager",
  "ttl": "1h",
  "groups_claim": "/resource_access/$CLIENT_ID/roles",
  "bound_claims": { "/resource_access/$CLIENT_ID/roles": ["manager"] },
  "verbose_oidc_logging": true
}
EOF

vault read auth/jwt/role/manager
