set -e

sudo docker volume create zwavejs2mqtt

sudo docker pull zwavejs/zwavejs2mqtt:latest

sudo docker stop zwavejs2mqtt || :
sudo docker rm zwavejs2mqtt || :

sudo docker run --name=zwavejs2mqtt \
  -d \
  --restart always \
  -v zwavejs2mqtt:/usr/src/app/store \
  --device="/dev/ttyUSB0" \
  --net=host \
  zwavejs/zwavejs2mqtt:latest
