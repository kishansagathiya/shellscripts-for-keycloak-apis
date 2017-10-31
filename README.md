# shellscripts-for-keycloak-apis

We can update the realm configuration without passing the entire configuration.json file. We just need to pass the field that we want to change and an identifier (id) in JSON format, except for Identity provider. While creating Identity provider, we need to pass the full json.

No need to pass full JSON
- A realm can be created by passing mandatory fields in json format. Update is possible by passing only those fields that we would like to change.

- A client can be created by passing mandatory field in json format. Update is possible by passing only those fields that we would like to change.

Have to pass full JSON
- An Identity Provider can be created by passing mandatory fields in json format, but update is possible only by passing the entire json. Otherwise it would empty the fields that are not passed


Getting admin Token 
```
POST /auth/realms/master/protocol/openid-connect/token HTTP/1.1
Host: http://keycloak-kc-kishan.dev.rdu2c.fabric8.io
Content-Type: application/x-www-form-urlencoded

grant_type=password&username=admin&password=admin&client_id=admin-cli

```

Creating Realm
```
POST /auth/admin/realms
Content-Type: application/json
Authorization: bearer $TOKEN

Payload: $REALMCONFIG_IN_JSON_FORMAT
```

Creating client
```
POST /auth/admin/realms/{realm}/clients/
Content-Type: application/json
Authorization: bearer $TOKEN

Payload: $CLIENTCONFIG_IN_JSON_FORMAT
```

Creating an Identity Provider
```
POST /auth/admin/realms/{realm}/identity-provider/instances
Content-Type: application/json
Authorization: bearer $TOKEN

Payload: $IDPCONFIG_IN_JSON_FORMAT
```


Updating Realm
```
PUT /auth/admin/realms/{realm}
Content-Type: application/json
Authorization: bearer $TOKEN

Payload: $REALMCONFIG_IN_JSON_FORMAT
```

Updating client
```
PUT /auth/admin/realms/{realm}/clients/{id}
Content-Type: application/json
Authorization: bearer $TOKEN

Payload: $CLIENTCONFIG_IN_JSON_FORMAT
```

Updating an Identity Provider
```
PUT /auth/admin/realms/{realm}/identity-provider/instances/{alias}?id={internalId}
Content-Type: application/json
Authorization: bearer $TOKEN

Payload: $IDPCONFIG_IN_JSON_FORMAT
```

To get internalId
```
GET /auth/admin/realms/{realm}/identity-provider/instances/{alias}
Accept: application/json
Authorization: bearer $TKN
```
