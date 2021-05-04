#!/bin/bash

set -ue
# source environment variables
source scripts/env.sh


DISCOVERY_URL="$KEYCLOAK_URL/realms/$REALM"
JWKS_URL="$KEYCLOAK_URL/realms/$REALM/protocol/openid-connect/certs"


vault write auth/jwt/config \
    default_role="reader" \
    bound_issuer="$DISCOVERY_URL" \
    jwks_url="$JWKS_URL"


# "aud" claim in JWT
vault write auth/jwt/role/reader \
    user_claim="sub" \
    role_type="jwt" \
    bound_audiences="account" \
    ttl=1h \
    policies="reader" \
    verbose_jwt_logging=true


vault read auth/jwt/role/reader
