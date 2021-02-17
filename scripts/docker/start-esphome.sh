set -e

sudo docker pull esphome/esphome

sudo mkdir -p /etc/esphome

sudo docker stop esphome || :
sudo docker rm esphome || :

sudo docker run --name=esphome \
  -d \
  --restart always \
  -v /etc/esphome:/config \
  --net=host \
  esphome/esphome
