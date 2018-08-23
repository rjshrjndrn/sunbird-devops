#!/bin/sh

ssh -i /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem -o CheckHostIP=no -o StrictHostKeyChecking=no ubuntu@13.232.188.44

sudo apt-get update -y && sudo apt-get install git -y

git clone https://github.com/project-sunbird/sunbird-devops.git