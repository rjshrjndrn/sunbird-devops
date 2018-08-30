set -eu -o pipefail
pip install pyyaml &&
sudo apt-get update -y &&
sudo apt-get install git -y &&
git clone $repo
exit 0