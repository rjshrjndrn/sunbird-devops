import json
import shlex
from subprocess import Popen, PIPE

command = "curl -X POST http://13.232.188.44/auth/realms/sunbird/protocol/openid-connect/token -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' -d 'client_id=admin-cli&username=user-manager&password=password&grant_type=password'"
p = Popen(shlex.split(command), stdin=PIPE, stdout=PIPE, stderr=PIPE)
output, err = p.communicate()

if p.returncode != 0:
    print(err)

j = json.loads(output.decode("utf-8"))
print '***********************************************************'
print(j['access_token'])
