import yaml
import os

fname = "configuration.yml"
configElement = ['env','implementation_name','ssh_ansible_user','sudo_passwd','ansible_private_key_path','application_host','app_address_space','dns_name','proto','database_host','database_password','keycloak_admin_password','sso_password','trampoline_secret','backup_storage_key','badger_admin_password','badger_admin_email','ekstep_api_key','sunbird_image_storage_url','sunbird_azure_storage_key','sunbird_azure_storage_account']
with open(fname, "w") as f:
   for key in configElement:
      configLine = key + ': ' + "NULL \n" if os.getenv(key) is None else os.getenv(key)+'\n'
      print configLine
      f.write(configLine)

