# GH Container registry token

## Create token
In GH developer setting create package:read token.
From that create AUTH_TOKEN:
```shell
echo -n <gh_username>:<gh_token> | base64
```
Set secret as TF_VAR `github_container_registry_secret_value` for `make secrets` to work. 