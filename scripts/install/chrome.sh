set -e

DEB=$HOME/Downloads/google-chrome-stable_current_amd64.deb

curl -o $DEB https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i $DEB

rm $DEB
