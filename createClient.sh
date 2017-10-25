#!/bin/bash

CONTENTS_OF_JSON='{
      "clientId": "testClient",
      "enabled": true,
      "standardFlowEnabled": true,
      "implicitFlowEnabled": false,
      "directAccessGrantsEnabled": true,
      "authorizationServicesEnabled": true,
      "fullScopeAllowed": true,
      "serviceAccountsEnabled": true,
      "clientAuthenticatorType": "client-secret",
      "secret": "addfc67d-8b85-49b1-969e-8f46c556fc67",
      "publicClient": true,
      "adminUrl": "",
      "baseUrl": "",
      "redirectUris": [
        "http://localhost:8080/api/login/*",
        "http://localhost:8089/*",
        "http://localhost:8080/*",
        "${JENKINS_URL}/securityRealm/finishLogin",
        "${KEYCLOAK_URL}/*"
      ],
      "webOrigins": [
        "*"
      ],
      "defaultRoles": [
        "uma_protection"
      ],
      "authorizationSettings": {
        "allowRemoteResourceManagement": true,
        "policyEnforcementMode": "ENFORCING",
        "scopes": [
          {
            "name": "read:space"
          },
          {
            "name": "admin:space"
          }
        ]
      }
    }'

export TKN=`curl -k -v -X POST "http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d 'password=admin' \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli' | jq -r '.access_token'`

curl -X POST http://keycloak-kc-kishan.dev.rdu2c.fabric8.io/auth/admin/realms/tobedeleted/clients/ \
  -H "Content-Type: application/json" \
  -H "Authorization: bearer $TKN" \
  -d "$CONTENTS_OF_JSON" \
  -D-
