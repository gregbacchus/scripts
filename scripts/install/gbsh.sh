set -e

mkdir -p ~/bin/

printf '#!/usr/bin/env sh\n\ncurl -sL https://sh.geee.be/$1/$2 | bash' > ~/bin/gbsh
chmod +x ~/bin/gbsh

[ ! `which gbsh` ] && printf 'Please add ~/bin to your PATH:\nexport PATH=$PATH:~/bin' || echo 'Installed. Usage: gbsh <section> <script>'
