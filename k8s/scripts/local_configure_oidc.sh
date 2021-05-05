#!/bin/bash

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
    ttl=1h \
    oidc_scopes="profile,roles" \
    groups_claim="/resource_access/$CLIENT_ID/roles" \
    allowed_redirect_uris="http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback,http://localhost:8200/ui/vault/auth/oidc/oidc/callback" \
    policies="reader" \
    verbose_oidc_logging=true


vault write auth/oidc/role/manager \
    user_claim="sub" \
    role_type="oidc" \
    bound_audiences="$CLIENT_ID" \
    ttl=1h \
    oidc_scopes="profile,roles" \
    groups_claim="/resource_access/$CLIENT_ID/roles" \
    allowed_redirect_uris="http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback,http://localhost:8200/ui/vault/auth/oidc/oidc/callback" \
    policies="manager" \
    verbose_oidc_logging=true

vault read auth/oidc/role/reader
