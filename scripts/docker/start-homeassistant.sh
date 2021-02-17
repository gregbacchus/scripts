set -e

sudo mkdir -p /data/homeassistant

sudo docker pull homeassistant/home-assistant:stable

sudo docker stop homeassistant || :
sudo docker rm homeassistant || :

sudo docker run --name=homeassistant \
  -d \
  --restart always \
  -v /data/homeassistant:/config \
  -v /etc/localtime:/etc/localtime:ro \
  --device="/dev/ttyUSB0" \
  --net=host \
  homeassistant/home-assistant:stable
