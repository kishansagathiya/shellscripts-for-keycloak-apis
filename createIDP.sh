#!/bin/bash

CONTENTS_OF_JSON='{  
   "config":{  
      "useJwksUrl":"true",
      "authorizationUrl":"http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/tobedeleted/broker/oidc-test/endpoint",
      "tokenUrl":"http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/tobedeleted/broker/oidc-test/endpoint",
      "clientId":"clientid",
      "clientSecret":"clientsecret"
   },
   "alias":"testIDP",
   "providerId":"oidc",
   "enabled":true,
   "authenticateByDefault":false,
   "firstBrokerLoginFlowAlias":"first broker login",
   "postBrokerLoginFlowAlias":""
}'

export TKN=`curl -k -v -X POST "http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d 'password=admin' \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token'`

curl -X POST http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/admin/realms/tobedeleted/identity-provider/instances \
  -H "Content-Type: application/json" \
  -H "Authorization: bearer $TKN" \
  -d "$CONTENTS_OF_JSON" \
  -D-
