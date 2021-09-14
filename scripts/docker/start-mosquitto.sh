set -e

sudo docker volume create mosquitto_data

sudo docker pull eclipse-mosquitto

sudo mkdir -p /etc/mosquitto
cat <<EOF | sudo tee /etc/mosquitto/mosquitto.conf
persistence true
persistence_location /mosquitto/data/
log_dest stdout
EOF

sudo docker stop mosquitto || :
sudo docker rm mosquitto || :

sudo docker run --name=mosquitto \
  -d \
  --restart always \
  -v mosquitto_data:/mosquitto/data \
  -v /etc/mosquitto:/mosquitto/config \
  --net=host \
  eclipse-mosquitto
