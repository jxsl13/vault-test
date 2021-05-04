#!/bin/bash


source scripts/env.sh

 
## Get Access-Token from client credentials
RESULT=`curl --silent --insecure \
  --request POST \
  --url "$KEYCLOAK_URL/realms/$REALM/protocol/openid-connect/token" \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data 'grant_type=password' \
  --data "client_id=$PUBLIC_CLIENT_ID" \
  --data "client_secret=$PUBLIC_CLIENT_SECRET" \
  --data "username=$USER_NAME" \
  --data "password=$PASSWORD"`

echo "Requested token:"
echo $RESULT
ACCESS_TOKEN=`echo $RESULT | sed 's/.*access_token":"//g' | sed 's/".*//g'`

vault write auth/jwt/login role="reader" jwt=$ACCESS_TOKEN

#curl \
#    --header "Authorization: Bearer $VAULT_TOKEN" \
#    --request POST \
#    --data '{"jwt": "$ACCESS_TOKEN", "role": "reader"}' \
#    $VAULT_ADDR/v1/auth/jwt/login

#curl --header "Authorization: Bearer $VAULT_TOKEN" --request GET $VAULT_ADDR/v1/auth/jwt/login

