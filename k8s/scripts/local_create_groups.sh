#!/bin/bash

# source environment variables & login as root user
source scripts/env.sh
source scripts/local_login.sh

# create external group and get its ID
MANAGER_GROUP_ID=`vault write identity/group name="keycloak_manager" type="external" policies="manager" metadata=responsibility="Manage K/V Secrets" -format=json | jq -r '.data.id'`

# create external group and get its ID
READER_GROUP_ID=`vault write identity/group name="keycloak_reader" type="external" policies="reader" metadata=responsibility="Read K/V Secrets" -format=json | jq -r '.data.id'`

echo "keycloak_manager ID: $MANAGER_GROUP_ID"
echo "keycloak_reader  ID: $READER_GROUP_ID"

LIST=`vault auth list -format=json`

# fetch accessor mounting points
JWT_ACCESSOR=`echo $LIST | jq -r '."jwt/".accessor'`
OIDC_ACCESSOR=`echo $LIST | jq -r '."oidc/".accessor'`



# oidc group aliases
echo "OIDC_ACCESSOR: $OIDC_ACCESSOR"
vault write identity/group-alias name="reader" \
    mount_accessor="$OIDC_ACCESSOR" \
    canonical_id="$READER_GROUP_ID"

vault write identity/group-alias name="manager" \
    mount_accessor="$OIDC_ACCESSOR" \
    canonical_id="$MANAGER_GROUP_ID"



# jwt group aliases
echo "JWT_ACCESSOR:  $JWT_ACCESSOR"
vault write identity/group-alias name="reader" \
    mount_accessor="$JWT_ACCESSOR" \
    canonical_id="$READER_GROUP_ID"

vault write identity/group-alias name="manager" \
    mount_accessor="$JWT_ACCESSOR" \
    canonical_id="$MANAGER_GROUP_ID"


