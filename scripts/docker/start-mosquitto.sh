set -e

sudo docker volume create mosquitto_data

sudo docker pull eclipse-mosquitto

sudo mkdir -p /etc/mosquitto
sudo touch /etc/mosquitto/mosquitto.conf

sudo docker stop mosquitto || :
sudo docker rm mosquitto || :

sudo docker run --name=mosquitto \
  -d \
  --restart always \
  -v mosquitto_data:/mosquitto/data \
  -v /etc/mosquitto:/mosquitto/config \
  -v /var/log/mosquitto/logs \
  --net=host \
  eclipse-mosquitto
