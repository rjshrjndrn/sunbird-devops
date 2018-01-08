### Installing and initializing dbs

> **Notes**  
As per security design, DB instance won't have internet access.  
So please log in to app server and to DB server to perform the following

1. git clone https://github.com/project-sunbird/sunbird-devops.git
2. ./sunbird-devops/deploy/generate-config.sh mysb dev deploy
3. Modifying db configs
```➜  deploy git:(master) ✗ vim ~/mysb-devops/ansible/inventories/dev/group_vars/dev
./sunbird-devops/deploy/generate-config.sh mysb dev deploy
# DB CONFIGURATION

## Below passwords are used by DB install scripts when creating databases. Please use strong passwords.
application_postgres_password: password   #Password for Application database.
keycloak_postgres_password: password       #Password for Keycloak (Authentication service) database.
kong_postgres_password: password           #Password for Kong (API Manager) database.

## Postgres configuration
swarm_address_space: 10.1.0.0/24  #Application server address space (e.g. 10.3.0.0/24), also the agentpublicSubnet if using Azure scripts provided

## Cassandra configuration
cassandra_server_private_ip: 10.1.0.4 #Private IP of cassandra server
keystore_password: password   #Password to use for encrypting cassandra keystore. Use a strong password.
truststore_password: password   #Password to use for encrypting cassandra truststore. Use a strong password.

## DB address
application_postgres_host: 10.1.0.4  #Private IP of Postgres server
keycloak_postgres_host: 10.1.0.4  #Private IP of Postgres server
kong_postgres_host: 10.1.0.4  #Private IP of Postgres server
sunbird_mongo_ip: 10.1.0.4 #Private IP of Mongo DB server
sunbird_cassandra_host: 10.1.0.4  #Private IP of Cassandra server
sunbird_es_host: 10.1.0.4   #Private IP of Elastic Search server. If ES cluster has multiple nodes then add all nodes by separating them with comma. e.g. 10.2.0.1,10.2.0.2,10.2.0.3
```
4. Installing DBs  
 `cd sunbird-devops/deploy`   
`sudo ./install-dbs.sh  mysb dev deploy`


5. Initializing DBs  
`sudo ./init-dbs <implementation-name>-devops/ansible/inventories/<environment-name>`  
eg:  
`sudo ./init-dbs.sh mysb-devops/ansible/inventories/dev`
