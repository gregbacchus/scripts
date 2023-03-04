set -e

sudo docker volume create zigbee2mqtt

sudo docker pull koenkk/zigbee2mqtt:latest

sudo docker stop zigbee2mqtt || :
sudo docker rm zigbee2mqtt || :

docker run --name zigbee2mqtt \
  --restart always \
  --device /dev/serial/by-id/usb-Nabu_Casa_SkyConnect_v1.0_7cf686328218ec119484e99a47486eb0-if00-port0:/dev/ttyACM0 \
  -v zigbee2mqtt:/app/data \
  -v /run/udev:/run/udev:ro \
  -e TZ=Pacific/Auckland \
  --net host \
  koenkk/zigbee2mqtt:latest
