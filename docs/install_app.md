# Deploying application and core services


**Prerequisites**

1. SSL certificates - public or [self-signed](self-signed-certs.md)

```
vim mysb-devops/ansible/inventories/dev/group_vars/dev
cd sunbird-devops/deploy
sudo ./install-deps.sh
sudo ./deploy-apis.sh /home/ops/mysb-devops/ansible/inventories/dev
```

_**Error:** Kong apis are not up_

## Changes made to make kong work

```
vim mysb-devops/ansible/inventories/dev/group_vars/dev change  kong_host to node_dns address or ip

ansible/roles/kong-consumer/defaults/main.yml

kong_admin_api_url: "http://localhost:8001" -> kong_admin_api_url: "http://{{kong_host}}:8001"
```

**Error**
`JWT token for player` didn't get
