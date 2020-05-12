set -e

mkdir -p ~/bin/

echo "#!/usr/bin/env sh\n\ncurl -sL sh.geee.be/$1/$2 | sh" > ~/bin/gbsh
chmod +x ~/bin/gbsh

[ ! `which gbsh` ] && printf 'Please add ~/bin to your PATH:\nexport PATH=$PATH:~/bin' || echo 'Installed. Usage: gbsh <section> <script>'
