# Deploying application and core services

> please ssh in to app server

**Prerequisites**

SSL certificates - public or [self-signed](self-signed-certs.md)

```
vim mysb-devops/ansible/inventories/dev/group_vars/dev
cd sunbird-devops/deploy
sudo ./install-deps.sh
sudo ./deploy-apis.sh /home/ops/mysb-devops/ansible/inventories/dev
```

1. `git clone https://github.com/project-sunbird/sunbird-devops.git`

2. Copy over the configuration directory from the DB server(<implementation-name>-devops) to this machine  
`scp ops@db_ip:/path/to/<implementation-name>-devops .`

3. Modify all the configurations under # APPLICATION CONFIGURATION block

4. The automated setup also creates a proxy server and like all proxy servers, it will require a SSL certificate. Details of the certificates have to added in the configuration, please see [this wiki](https://github.com/project-sunbird/sunbird-devops/wiki/Updating-SSL-certificates-in-Sunbird-Proxy-service) for details on how to do this. Note: If you don't have SSL certificates and want to get started you could generate and use [self-signed certificates](https://en.wikipedia.org/wiki/Self-signed_certificate), steps for this are detailed in [this wiki](https://github.com/project-sunbird/sunbird-devops/wiki/Generating-a-self-signed-certificate)

- Run `cd sunbird-devops/deploy`
- Run `sudo ./install-deps.sh`. This will install dependencies.
- Run `sudo ./deploy-apis.sh <implementation-name>-devops/ansible/inventories/<environment-name>`. This will onboard various APIs and consumer groups.

_**Error:** Kong apis are not up_

**Changes made to make kong work** 

```
vim mysb-devops/ansible/inventories/dev/group_vars/dev change  kong_host to node_dns address or ip

ansible/roles/kong-consumer/defaults/main.yml

kong_admin_api_url: "http://localhost:8001" -> kong_admin_api_url: "http://{{kong_host}}:8001"
```

**Note:** Next 2 steps are necessary only when the application is being deployed for the first time and could be skipped for subsequent deploys.

- deploy-apis.sh script will print a JWT token that needs to be updated in the application configuration. To find the token search the script output to look for "JWT token for player is :", copy the corresponding token. Example output below, token is highlighted in italics:

  > changed: [localhost] => {"changed": true, "cmd": "python /tmp/kong-api-scripts/kong_consumers.py
  /tmp/kong_consumers.json ....... "**JWT token for player is :**
  *eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJlMzU3YWZlOTRmMjA0YjQxODZjNzNmYzQyMTZmZDExZSJ9.L1nIxwur1a6xVmoJZT7Yc0Ywzlo4v-pBVmrdWhJaZro*", "Updating rate_limit for consumer player for API cr......"]}

- Update `sunbird_api_auth_token` in your configuration with the above copied token.
- Obtain API token from Ekstep platform by following steps listed [here](https://github.com/project-sunbird/sunbird-commons/wiki/Obtaining-API-token-for-accessing-ekstep-APIs)
- Update `sunbird_ekstep_api_key` in your configuration with the API token obtained from ekstep portal

- Keycloak is deployed on vm. RUN `./provision-keycloak.sh <implementation-name>-devops/ansible/inventories/<environment-name>` this script creates the keycloak username,groupname and servicify keycloak service on vm.

- Update below variables in the config ` <implementation-name>-devops/ansible/inventories/<environment-name>/group_vars/<environment-name>`.
```
 keycloak_password: (which admin initial password)
 keycloak_theme_path: ex- path/to/the/nile/themes. Sample themes directory of sunbird can be seen [here](https://github.com/project-sunbird/sunbird-devops/tree/master/ansible/artifacts)
```
- Run `sudo ./deploy-keycloak-vm.sh <implementation-name>-devops/ansible/inventories/<environment-name>`.

- Follow the instructions [here](https://github.com/project-sunbird/sunbird-commons/wiki/Keycloak-realm-configuration) to setup auth realm in keycloak

- Update following configs

```yml
# Login to the keycloak admin console, goto the clients->admin-cli->Installation->Select json format
sunbird_sso_client_id: # Eg: admin-cli
sunbird_sso_username: # keycloak user name
sunbird_sso_password: # keycloak user password

# Login to the keycloak admin console, goto the clients->portal->Installation->Select json format
keycloak_realm:  # Eg: sunbird
sunbird_keycloak_client_id: # Eg: portal

# Login to the keycloak admin console, goto the clients->trampoline->Installation->Select json format
sunbird_trampoline_client_id:  # Eg: trampoline
sunbird_trampoline_secret:     # Eg: HJKDHJEHbdggh23737
```

### Additional config to customize Sunbird instance
Sunbird supports customization of home page, logo, and fav icon for the portal. The customizations can be loaded by mounting the volume containing the customizations into the docker container.

- Uncomment and set the value for the variable `player_tenant_dir` in `<implementation-name>-devops/ansible/inventories/<environment-name>/group_vars/<environment-name>`. For example, `player_tenant_dir: /data/extensions/tenant`.
  - **NOTE**: If the variable `player_tenant_dir` is commented, the volume will not be mounted and customizations will not be loaded.
- Create the above folder (e.g. /data/extensions/tenant) on all the docker swarm nodes. Permissions of the folder should be `mode=0775`,`user=root` and `group=root`.
- This [wiki](https://github.com/project-sunbird/sunbird-commons/wiki/Deploying-Custom-html-pages-and-images) contains the instructions to deploy custom home pages and images.

### Deploying Sunbird services
- Run `sudo ./deploy-core.sh <implementation-name>-devops/ansible/inventories/<environment-name>`. This will setup all the sunbird core services.
- Run `sudo ./deploy-proxy.sh <implementation-name>-devops/ansible/inventories/<environment-name>`. This will setup sunbird proxy services.

