import json
import shlex
import os
from subprocess import Popen, PIPE
import yaml

with open("/home/ubuntu/config", 'r') as stream:
	cfg = yaml.load(stream)
dns_name = cfg['dns_name']
password = cfg['sso_password']

curlForAccessToken = "curl -X POST http://"+dns_name+"/auth/realms/sunbird/protocol/openid-connect/token -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' -d 'client_id=admin-cli&username=user-manager&password="+password+"&grant_type=password'"
p = Popen(shlex.split(curlForAccessToken), stdin=PIPE, stdout=PIPE, stderr=PIPE)
output, err = p.communicate()
if p.returncode != 0:
    print(err)

j = json.loads(output.decode("utf-8"))

print dns_name
print "-----------------------------------"
print password
print "-----------------------------------"
print curlForAccessToken
print "-----------------------------------"
print j['access_token']

with open("/home/ubuntu/jwt_token_player.txt", 'r') as file:
	for _ in range(1):
    		jwt = file.readline().strip()
print "-----------------------------------"
print jwt
print "-----------------------------------"

createRootOrg = "curl -X POST  http://"+dns_name+"/api/org/v1/create -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' -H 'accept: application/json' -H 'authorization: Bearer "+jwt+"' -H 'x-authenticated-user-token: "+j['access_token']+"' -d '{\"request\":{  \"orgName\": \"TestingForOrgCreation\", \"description\": \"TestingForOrgCreation_description\",  \"isRootOrg\":true,  \"channel\":\"TestingForOrgCreation\" } }'"

print "-----------------------------------"
print createRootOrg
print "-----------------------------------"
org = Popen(shlex.split(createRootOrg), stdin=PIPE, stdout=PIPE, stderr=PIPE)
orgoutput, err = org.communicate()
if org.returncode != 0:
    print(err)

orgcreated = json.loads(orgoutput.decode("utf-8"))
print "-----------------------------------"
print orgcreated
print "-----------------------------------"