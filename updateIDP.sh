#!/bin/bash

CONTENT_OF_THE_JSONFILE = '{"alias":"testIDP",
   "internalId":"0cc580ab-d288-4205-be0f-f8f868e04020",
   "providerId":"oidc",
   "config":{  
      "useJwksUrl":"true",
      "authorizationUrl":"http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/tobedeleted/broker/oidc-test/endpoint",
      "tokenUrl":"http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/tobedeleted/broker/oidc-test/endpoint",
      "clientId":"clientid",
      "clientSecret":"clientsecret"
   }
}'

export TKN=`curl -k -v -X POST "http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d 'password=admin' \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token'`

# updating with parts of JSON is not possible, because what whichever field that are not passed in the JSON it assumes them to be empty (It would also empty the field that are mandatory)


export IID=`curl -X GET http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/admin/realms/tobedeleted/identity-provider/instances/testIDP \
  -H "Accept: application/json" \
  -H "Authorization: bearer $TKN" | jq -r '.internalId'`

curl -X PUT "http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/admin/realms/tobedeleted/identity-provider/instances/testIDP?id=$IID" \
  -H "Content-Type: application/json" \
  -H "Authorization: bearer $TKN" \
  -d "{\"alias\":\"testIDP\", \"internalId\":\"$IID\", \"firstBrokerLoginFlowAlias\":\"first broker login\"}" \
  -D-