set -eu -o pipefail
sudo add-apt-repository ppa:jonathonf/python-3.6 &&
sudo apt-get update -y &&
sudo apt-get install git -y &&
sudo apt-get install build-essential libpq-dev libssl-dev openssl libffi-dev zlib1g-dev &&
sudo apt-get install python3-pip python3-dev &&
pip install pyyaml &&
git clone $1 &&
cp config sunbird-devops/deploy &&
eval `ssh-agent -s` &&
ssh-add ciTestKey.pem &&
chmod 0400 ciTestKey.pem &&
exit 0