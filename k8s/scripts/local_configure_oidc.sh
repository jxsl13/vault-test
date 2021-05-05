#!/bin/bash

set -ue
# source environment variables
source scripts/env.sh


DISCOVERY_URL="$KEYCLOAK_URL/realms/$REALM"


vault write auth/oidc/config \
    default_role="reader" \
    bound_issuer="$DISCOVERY_URL" \
    oidc_discovery_url="$DISCOVERY_URL" \
    oidc_client_id="$CLIENT_ID" \
    oidc_client_secret="$CLIENT_SECRET"


# "aud" claim in oidc
vault write auth/oidc/role/reader \
    user_claim="sub" \
    role_type="oidc" \
    bound_audiences="$CLIENT_ID" \
    groups_claim="/resource_access/$CLIENT_ID/roles" \
    ttl=1h \
    allowed_redirect_uris="http://localhost:8200/ui/vault/auth/oidc/oidc/callback,http://localhost:8250/oidc/callback" \
    policies="reader" \
    verbose_oidc_logging=true


vault write auth/oidc/role/manager \
    user_claim="sub" \
    role_type="oidc" \
    bound_audiences="$CLIENT_ID" \
    groups_claim="/resource_access/$CLIENT_ID/roles" \
    ttl=1h \
    allowed_redirect_uris="http://localhost:8200/ui/vault/auth/oidc/oidc/callback,http://localhost:8250/oidc/callback" \
    policies="manager" \
    verbose_oidc_logging=true

vault read auth/oidc/role/reader
