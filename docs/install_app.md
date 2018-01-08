### SSH to app server

**Error**
ansible-playbook not found
copied groupvars/dev from db server

`sudo ./deploy-core.sh ~/mysb-devops/ansible/inventories/dev`

```
TASK [stack-sunbird : Save service configurations into an env file] ******************************************************************************************
fatal: [localhost]: FAILED! => {"changed": false, "msg": "AnsibleUndefinedVariable: 'sunbird_msg_91_auth' is undefined"}
  to retry, use: --limit @/home/ops/sunbird-devops/ansible/deploy.retry

PLAY RECAP ***************************************************************************************************************************************************
localhost                  : ok=5    changed=0    unreachable=0    failed=1
```

_**Manoj**: use release 1.4_

> It worked, finished with ignore errors

## CONFIGURING KEYCLOAK ???


# Using old documentation for configuring app server

**Creating selfsigned certs**
```mkdir cert
cd certs
openssl genrsa -out "root-ca.key" 4096
openssl req \
       -new -key "root-ca.key" \
       -out "root-ca.csr" -sha256 \
       -subj '/C=IN/ST=KA/L=Bengaluru/O=Sunbird/CN=Sunbird Example CA'
vim root-ca.cnf
openssl x509 -req  -days 3650  -in "root-ca.csr" \
            -signkey "root-ca.key" -sha256 -out "root-ca.crt" \
            -extfile "root-ca.cnf" -extensions \
            root_ca
openssl genrsa -out "site.key" 4096
openssl req -new -key "site.key" -out "site.csr" -sha256 \
      -subj '/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost'

vim site.cnf 

openssl x509 -req -days 750 -in "site.csr" -sha256 \
-CA "root-ca.crt" -CAkey "root-ca.key"  -CAcreateserial \
-out "site.crt" -extfile "site.cnf" -extensions server
```
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
