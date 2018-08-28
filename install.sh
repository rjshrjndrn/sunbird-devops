#!/bin/bash

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem # Allow read access to the private key
ssh-add /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem # Add the private key to SSH

scp /home/travis/build/rajeevsathish/sunbird-devops/configuration.yml ubuntu@$dns_name:.
# Skip this command if you don't need to execute any additional commands after deploying.
ssh -tt ubuntu@$dns_name <<EOF
  echo "1. Logged into the app server SUCCESSFULLY."
  sudo apt-get update -y
  echo "2. System updated SUCCESSFULLY."
  sudo apt-get install git -y
  echo "3. Git installed SUCCESSFULLY."
  echo "4. Identity added SUCCESSFULLY."
  echo "THE REPO VARIABLE VALUE IS =====> $repo"
  git clone $repo
  echo "5. Installer downloaded SUCCESSFULLY."
  eval `ssh-agent -s`
  ssh-add /home/ubuntu/sunbird-devops/deploy/ciTestKey.pem
  echo "6. ssh added SUCCESSFULLY."
  cd sunbird-devops/deploy
  eval `ssh-agent -s`
  ssh-add ciTestKey.pem
  chmod 0400 ciTestKey.pem
  echo "Sunbir installation starting..."
  echo "INSTALLATION CODE SHOULD COME HERE"

EOF




#!/bin/sh
# ./sunbird_install.sh
# chmod 0400 /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem
# ssh -i /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem -o CheckHostIP=no -o StrictHostKeyChecking=no ubuntu@13.232.188.44
# &&
# sudo apt-get update -y && sudo apt-get install git -y &&
# git clone https://github.com/project-sunbird/sunbird-devops.git
# chmod 0400 /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem
# nssh() {
#     ssh -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking false" -o "LogLevel ERROR" $@
#     return $?
# }
# # nssh -i /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem ubuntu@13.232.188.44 
# sudo apt-get update -y && 
# sudo apt-get install git -y && 
# eval `ssh-agent -s` && 
# ssh-add /home/ubuntu/ciTestKey.pem && 
# git clone https://github.com/rajeevsathish/sunbird-devops.git && 
# cd sunbird-devops/deploy && 
# ./sunbird_install.sh
# nssh -i /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem ubuntu@13.232.188.44 echo "Test"


