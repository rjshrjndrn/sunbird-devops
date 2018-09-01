set -eu -o pipefail
sudo add-apt-repository ppa:jonathonf/python-2.7 &&
sudo apt-get -y update &&
sudo apt-get install git -y &&
sudo apt-get install python2.7 python2.7 libpython2.7 -y &&
pip install pyyaml &&
git clone $1 &&
cp config sunbird-devops/deploy &&
eval `ssh-agent -s` &&
ssh-add ciTestKey.pem &&
chmod 0400 ciTestKey.pem &&
exit 0