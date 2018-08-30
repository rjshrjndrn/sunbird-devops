#!/bin/bash

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem # Allow read access to the private key
ssh-add /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem # Add the private key to SSH

scp /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem ubuntu@$dns_name:.
scp /home/travis/build/rajeevsathish/sunbird-devops/config ubuntu@$dns_name:.
scp /home/travis/build/rajeevsathish/sunbird-devops/getSSOKey.py ubuntu@$dns_name:.

ssh -i /home/travis/build/rajeevsathish/sunbird-devops/ciTestKey.pem ubuntu@$dns_name bash /home/ubuntu/sunbird-devops/stage1.sh
echo $?
# Skip this command if you don't need to execute any additional commands after deploying.
# ssh -tt ubuntu@$dns_name <<EOF
#   echo "1. Logged into the app server SUCCESSFULLY."
#   pip install pyyaml
#   sudo apt-get update -y
#   echo "2. System updated SUCCESSFULLY."
#   sudo apt-get install git -y
#   echo "3. Git installed SUCCESSFULLY."
#   echo "4. Identity added SUCCESSFULLY."
#   echo "THE REPO VARIABLE VALUE IS =====> $repo"
#   git clone $repo
#   echo "5. Installer downloaded SUCCESSFULLY."
#   cp config sunbird-devops/deploy
#   echo "6. ssh added SUCCESSFULLY."
#   cd sunbird-devops/deploy
#   eval `ssh-agent -s`
#   ssh-add ciTestKey.pem
#   chmod 0400 ciTestKey.pem
#   echo "Sunbir installation starting..."
#   echo "INSTALLATION CODE SHOULD COME HERE"
#   ./sunbird_install.sh; echo "Installation phase ONE complete";echo "Updating the config for SSO_KEY"; python /home/ubuntu/getSSOKey.py; cp config sunbird-devops/deploy ;./sunbird_install.sh -s core
# EOF
# echo "--------------------------------------------------------"
# echo "I am trying to run this script to see where it executes"
# echo "--------------------------------------------------------"

  # if [ $? = 0 ]; then python /home/ubuntu/getSSOKey.py;else python /home/ubuntu/getSSOKey.py; if

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


