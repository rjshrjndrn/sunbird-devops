set -eu -o pipefail
ssh-keyscan -H $dns_host >> ~/.ssh/known_hosts
ssh-keyscan -H $db_public_ip >> ~/.ssh/known_hosts
exit 0