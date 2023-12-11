set -e

sudo mkdir -p /data/homeassistant

sudo docker pull ghcr.io/home-assistant/home-assistant:stable

sudo docker stop homeassistant || :
sudo docker rm homeassistant || :

sudo docker run --name homeassistant \
  -d \
  --restart always \
  -v /data/homeassistant:/config \
  -v /etc/localtime:/etc/localtime:ro \
  --device /dev/ttyUSB0:/dev/ttyUSB0 \
  --device /dev/ttyUSB1:/dev/ttyUSB1 \
  -e TZ=Pacific/Auckland \
  --net host \
  ghcr.io/home-assistant/home-assistant:stable
