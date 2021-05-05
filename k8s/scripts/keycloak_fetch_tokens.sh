#!/bin/bash


source scripts/env.sh


READER_RESULT=`curl --silent --insecure \
  --request POST \
  --url "$KEYCLOAK_URL/realms/$REALM/protocol/openid-connect/token" \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data 'grant_type=password' \
  --data "client_id=$CLIENT_ID" \
  --data "client_secret=$CLIENT_SECRET" \
  --data "username=$READER_USER_NAME" \
  --data "password=$READER_PASSWORD" \
  --data "scope=openid"`


READER_ACCESS_TOKEN=`echo $READER_RESULT | jq -r '.access_token'`
echo "access_token: $READER_ACCESS_TOKEN"
echo ""
READER_ID_TOKEN=`echo $READER_RESULT | jq -r '.id_token'`
echo "id_token: $READER_ID_TOKEN"

