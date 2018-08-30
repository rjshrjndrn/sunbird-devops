set -eu -o pipefail
python /home/ubuntu/getSSOKey.py &&
cp config sunbird-devops/deploy &&
cd sunbird-devops/deploy &&
./sunbird_install.sh -s core
exit 0