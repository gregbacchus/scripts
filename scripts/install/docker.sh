set -e

source /etc/os-release

if [[ ! "$ID $ID_LIKE" =~ .*ubuntu.* ]]; then
  echo 'THis script is for ubuntu based OSs only'
  exit 1
fi

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update
sudo apt-get install -i \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
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
