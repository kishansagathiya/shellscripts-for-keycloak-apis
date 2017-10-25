#!/bin/bash

# CONTENT_OF_THE_JSONFILE=$(<client.json)
# this one seems to work well
# feeding parts of JSON doesn't empty other things

export TKN=`curl -k -v -X POST "http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d 'password=admin' \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token'`
# clients/id, id is variable here

curl -X PUT http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/admin/realms/tobedeleted/clients/a3425f37-2b49-4fcb-bfee-4395be9319de \
  -H "Content-Type: application/json" \
  -H "Authorization: bearer $TKN" \
  -d '{ "clientId": "testClient", "name": "testClient2"}' \
  -D-