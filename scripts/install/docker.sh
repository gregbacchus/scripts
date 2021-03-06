set -e

source /etc/os-release

if [[ ! "$ID $ID_LIKE" =~ .*ubuntu.* ]]; then
  echo 'THis script is for ubuntu based OSs only'
  exit 1
fi

sudo apt-get remove docker docker-engine docker.io containerd runc || :

sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

OS_RELEASE=$(lsb_release -cs)
# HACK until focal is supported
[[ "$OS_RELEASE" == 'focal' ]] && OS_RELEASE=eoan

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $OS_RELEASE \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

[ ! -f /etc/docker/daemon.json ] && cat <<'EOF' | sudo tee /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
EOF

sudo usermod -aG docker $USER

echo "Docker installed"
