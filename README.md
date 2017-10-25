# shellscripts-for-keycloak-apis

We can update the realm configuration without passing the entire configuration.json file. We just need to pass the field that we want to change and an identifier (id) in JSON format, except for Identity provider. While creating Identity provider, we need to pass the full json.

- A realm can be created by passing mandatory fields in json format. Update is possible by passing only those fields that we would like to change.

- A client can be created by passing mandatory field in json format. Update is possible by passing only those fields that we would like to change.

- An Identity Provider can be created by passing mandatory fields in json format, but update is possible only by passing the entire json. Otherwise it would empty the fields that are not passed
