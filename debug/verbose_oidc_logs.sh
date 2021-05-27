
# this script is used to enable verbose logging of id_tokens returned by the keycloak IDP
# this cannot be done via the playbook, as it turns off verbose logging by default.
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=<INSERT TOKEN>
export CLIENT_ID=vault-ansible-001

vault write auth/oidc/role/manager \
    user_claim="sub" \
    role_type="oidc" \
    bound_audiences="$CLIENT_ID" \
    groups_claim="/resource_access/$CLIENT_ID/roles" \
    ttl=1h \
    allowed_redirect_uris="http://localhost:8200/ui/vault/auth/oidc/oidc/callback,http://localhost:8250/oidc/callback" \
    policies="manager" \
    verbose_oidc_logging=true

vault debug