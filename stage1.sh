set -eu -o pipefail
sudo apt-get update &&
sudo apt-get install python3.6 &&
pip install pyyaml &&
sudo apt-get update -y &&
sudo apt-get install git -y &&
git clone $1 &&
cp config sunbird-devops/deploy &&
eval `ssh-agent -s` &&
ssh-add ciTestKey.pem &&
chmod 0400 ciTestKey.pem &&
exit 0