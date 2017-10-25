#!/bin/bash

# CONTENT_OF_THE_JSONFILE=$(<fullConfig.json)
# Seems to be working fine. Parts of JSON doesn't empty other things

export TKN=`curl -k -v -X POST "http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d 'password=admin' \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token'`

curl -X PUT http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/admin/realms/tobedeleted \
  -H "Content-Type: application/json" \
  -H "Authorization: bearer $TKN" \
  -d '{"enabled":true,"id":"tobedeleted","realm":"tobedeleted", "accessTokenLifespan": 2592000, "accessTokenLifespanForImplicitFlow": 1296000}' \
  -D-
