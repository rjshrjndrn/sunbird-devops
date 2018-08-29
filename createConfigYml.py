import os

configVars = ['env','implementation_name','ssh_ansible_user','ansible_private_key_path','application_host','app_address_space','dns_name','proto','database_host','database_password','keycloak_admin_password','sso_password','trampoline_secret','backup_storage_key','badger_admin_password','badger_admin_email','ekstep_api_key','sunbird_image_storage_url','sunbird_azure_storage_key','sunbird_azure_storage_account']
configToWrite = []
contentToCreateCurl = []
with open('config_templet','r') as fp:
	lines = fp.readlines()
	for line in lines:
		for key in configVars:
			if key in line:
				keyName = key+ ':'
				keyValue = keyName +' '+ os.getenv(key)
				line = line.replace(keyName, keyValue)
				contentToCreateCurl.insert(len(contentToCreateCurl),keyValue)
		configToWrite.insert(len(configToWrite),line)
fp.close()

with open('config','w') as fp:
	fp.writelines(configToWrite)
fp.close()
with open('confValue.yml','w') as fp:
	fp.writelines(contentToCreateCurl)
fp.close()

# import yaml
# # import os

# # fname = "config"
# # configElement = ['env','implementation_name','ssh_ansible_user','sudo_passwd','ansible_private_key_path','application_host','app_address_space','dns_name','proto','database_host','database_password','keycloak_admin_password','sso_password','trampoline_secret','backup_storage_key','badger_admin_password','badger_admin_email','ekstep_api_key','sunbird_image_storage_url','sunbird_azure_storage_key','sunbird_azure_storage_account']
# # with open(fname, "w") as f:
# #    for key in configElement:
# #       configLine = key + ': ' + "NULL \n" if os.getenv(key) is None else key + ': ' + os.getenv(key)+'\n'
# #       print configLine
# #       f.write(configLine)
# #       
# #       
