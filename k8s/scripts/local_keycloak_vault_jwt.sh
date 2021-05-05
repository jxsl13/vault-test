#!/bin/bash


source scripts/env.sh

 
## Get Access-Token for manager
MANAGER_RESULT=`curl --silent --insecure \
  --request POST \
  --url "$KEYCLOAK_URL/realms/$REALM/protocol/openid-connect/token" \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data 'grant_type=password' \
  --data "client_id=$PUBLIC_CLIENT_ID" \
  --data "client_secret=$PUBLIC_CLIENT_SECRET" \
  --data "username=$MANAGER_USER_NAME" \
  --data "password=$MANAGER_PASSWORD"`

MANAGER_ACCESS_TOKEN=$(echo $MANAGER_RESULT | jq -r '.access_token')
echo "Requested MANAGER token: $MANAGER_ACCESS_TOKEN"


echo "# Manager logs in as role reader"
vault write auth/jwt/login role="reader" -format=json jwt=$MANAGER_ACCESS_TOKEN | jq -r '.auth.client_token' > ~/.vault-token

# try to do stuff as reader write stuff
vault kv put secret/webapp/config manager="reader" || true

echo "# Manager logs in as role manager"
vault write auth/jwt/login role="manager" -format=json jwt=$MANAGER_ACCESS_TOKEN | jq -r '.auth.client_token' > ~/.vault-token

# write stuff, should work
vault kv put secret/webapp/config manager="manager"


############## READ ONLY USER ############## 

## Get Access-Token from client credentials
READER_RESULT=`curl --silent --insecure \
  --request POST \
  --url "$KEYCLOAK_URL/realms/$REALM/protocol/openid-connect/token" \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data 'grant_type=password' \
  --data "client_id=$PUBLIC_CLIENT_ID" \
  --data "client_secret=$PUBLIC_CLIENT_SECRET" \
  --data "username=$READER_USER_NAME" \
  --data "password=$READER_PASSWORD"`


READER_ACCESS_TOKEN=`echo $READER_RESULT | jq -r '.access_token'`
echo "Requested token: $READER_ACCESS_TOKEN"

# login as read only user

echo "# Reader logs in as role reader"
vault write auth/jwt/login role="reader" -format=json jwt=$READER_ACCESS_TOKEN | jq -r '.auth.client_token' > ~/.vault-token

# this should fail, try to write stuff
vault kv put secret/webapp/config reader="reader" || true


echo "# Reader logs in as role manager"
vault write auth/jwt/login role="manager" -format=json jwt=$READER_ACCESS_TOKEN | jq -r '.auth.client_token' > ~/.vault-token

# this should fail, try to write stuff, but do not really have permission to, because user should be a reader user
vault kv put secret/webapp/config reader="manager"