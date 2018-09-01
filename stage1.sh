set -eu -o pipefail
sudo add-apt-repository ppa:jonathonf/python-3.6 &&
sudo apt-get update -y &&
sudo apt-get install git -y &&
sudo apt-get install python3.6 python3.6 libpython3.6 &&
pip install pyyaml &&
git clone $1 &&
cp config sunbird-devops/deploy &&
eval `ssh-agent -s` &&
ssh-add ciTestKey.pem &&
chmod 0400 ciTestKey.pem &&
exit 0