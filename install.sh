#!/bin/bash

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem # Allow read access to the private key
ssh-add /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem # Add the private key to SSH

scp /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem ubuntu@$dns_name:.
scp /home/travis/build/rajeevsathish/sunbird-devops/config ubuntu@$dns_name:.
scp /home/travis/build/rajeevsathish/sunbird-devops/getSSOKey.py ubuntu@$dns_name:.
scp /home/travis/build/rajeevsathish/sunbird-devops/stage1.sh ubuntu@$dns_name:.
ssh -i /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem ubuntu@$dns_name bash /home/ubuntu/stage1.sh $repo
if [ $? -eq 0 ]
  then
    echo "Stage 1 SUCCESSFULL"
    ssh -i /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem ubuntu@$dns_name bash /home/ubuntu/sunbird-devops/stage2.sh
    if [ $? -eq 0 ]
      then
        echo "Stage 2 SUCCESSFULL"
        ssh -i /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem ubuntu@$dns_name bash /home/ubuntu/sunbird-devops/stage3.sh
        if [$? -eq 0]
          then
            echo "Stage 3 SUCCESSFULL"
            exit 0
          else
            echo "Stage 3 UNSUCCESSFULL" >&2
            exit 1
        fi
      else
        echo "Stage 2 UNSUCCESSFULL" >&2
        exit 1
    fi
  else
    echo "Stage 1 UNSUCCESSFULL" >&2
    exit 1
fi