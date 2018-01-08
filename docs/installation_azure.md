## Installation steps for azure 

> Prerequisites  
You have to have install docker-ce  
and `sudo usermod -aG docker $(whoami)`

1. git clone https://github.com/project-sunbird/sunbird-devops.git
2. ./sunbird-devops/deploy/generate-config.sh mysb dev cloud

3. **Editing azuredeploy.parameters.json (in app/ and db/) and env.sh**  

    *app/parameter.json*

    ```
    please make sure that you've quota for which you're assigning instance
    Changed sshRSAPublicKey: to my key
    ```
    *app/env.sh*
    ```
    AZURE_SUBSCRIPTION=
    AZURE_RG_LOCATION=centralindia
    ```
    *db/parametor.json*
    ```
    adminPublicKey  
    ```
4. Assigning ENV vars  
    ```
    export APP_DEPLOYMENT_JSON_PATH=~/mysb-devops/dev/azure/app 
    export DB_DEPLOYMENT_JSON_PATH=~/mysb-devops/dev/azure/db
    ```
5. Running provision servers. You can give `--debug` for verbose output
    ```
    cd sunbird-devops/deploy
    ./provision-servers.sh
    ```
[ **Installing DB** ](install_db.md)

[ **Installing APP** ](install_app.md)
