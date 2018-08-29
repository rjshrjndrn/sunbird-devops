import json
import shlex
import os
from subprocess import Popen, PIPE
import yaml

with open("config", 'r') as stream:
	cfg = yaml.load(stream)
	#print(cfg['keycloak_admin_password'])
curlForAccessToken = "curl -X POST http://"+cfg['dns_name']+"/auth/realms/master/protocol/openid-connect/token -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' -d 'client_id=admin-cli&username=admin&password="+cfg['keycloak_admin_password']+"&grant_type=password'"
p = Popen(shlex.split(curlForAccessToken), stdin=PIPE, stdout=PIPE, stderr=PIPE)
output, err = p.communicate()

if p.returncode != 0:
    print(err)

j = json.loads(output.decode("utf-8"))

# print '***********************************************************'
# print(curlForAccessToken)
# print '***********************************************************'

curlForPublicKey = "curl -X GET http://"+cfg['dns_name']+"/auth/admin/realms/sunbird/keys -H 'Authorization: Bearer "+j['access_token']+"' -H 'Cache-Control: no-cache' -H 'Content-Type: application/json'"

# print '-----------------------------------------------------------'
# print curlForPublicKey
# print '-----------------------------------------------------------'

p = Popen(shlex.split(curlForPublicKey), stdin=PIPE, stdout=PIPE, stderr=PIPE)
output, err = p.communicate()

if p.returncode != 0:
    print(err)

j = json.loads(output.decode("utf-8"))

# print '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
# print (j['keys'][0]['publicKey'])
# print '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

stream.close()

configToWrite = []
with open('config','r') as fp:
	lines = fp.readlines()
	for line in lines:
		key = 'sunbird_sso_publickey'
		if key in line:
			keyName = key+ ':'
			keyValue = keyName +' '+ j['keys'][0]['publicKey']
			line = line.replace(keyName, keyValue)
		configToWrite.insert(len(configToWrite),line)
fp.close()

with open('config','w') as fp:
	fp.writelines(configToWrite)
fp.close()
