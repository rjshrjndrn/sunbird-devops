#!/bin/bash

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem # Allow read access to the private key
ssh-add /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem # Add the private key to SSH


# Skip this command if you don't need to execute any additional commands after deploying.
ssh ubuntu@13.232.188.44 <<EOF
  echo "1. Logged into the app server SUCCESSFULLY."
  sudo apt-get update -y
  echo "2. System updated SUCCESSFULLY."
  sudo apt-get install git -y
  echo "3. Git installed SUCCESSFULLY."
  eval `ssh-agent -s`
  ssh-add /home/ubuntu/ciTestKey.pem
  echo "4. Identity added SUCCESSFULLY."
  git clone https://github.com/rajeevsathish/sunbird-devops.git
  echo "5. Installer downloaded SUCCESSFULLY."
  cd sunbird-devops/deploy
  echo "Sunbir installation starting..."
  ./sunbird_install.sh
EOF




#!/bin/sh

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


