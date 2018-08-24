#!/bin/sh

# chmod 0400 /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem
# ssh -i /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem -o CheckHostIP=no -o StrictHostKeyChecking=no ubuntu@13.232.188.44
# &&
# sudo apt-get update -y && sudo apt-get install git -y &&
# git clone https://github.com/project-sunbird/sunbird-devops.git
chmod 0400 /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem
nssh() {
    ssh -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking false" -o "LogLevel ERROR" $@
    return $?
}
# nssh -i /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem ubuntu@13.232.188.44 sudo apt-get update -y && sudo apt-get install git -y && eval `ssh-agent -s` && ssh-add /home/ubuntu/ciTestKey.pem && git clone https://github.com/rajeevsathish/sunbird-devops.git && cd sunbird-devops/deploy && ./sunbird_install.sh
nssh -i /home/travis/build/rajeevsathish/sunbird-devops/deploy/ciTestKey.pem ubuntu@13.232.188.44 echo "Test"