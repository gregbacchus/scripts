set -e

sudo mkdir -p /data/homeassistant

sudo docker pull homeassistant/home-assistant:stable

sudo docker stop homeassistant || :
sudo docker rm homeassistant || :

sudo docker run -d --name=homeassistant \
  -v /data/homeassistant:/config \
  -v /etc/localtime:/etc/localtime:ro \
  --device="/dev/ttyUSB0" \
  --restart=always \
  --net=host \
  homeassistant/home-assistant:stable
