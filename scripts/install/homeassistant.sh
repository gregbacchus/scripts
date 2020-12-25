set -e

docker pull homeassistant/home-assistant:stable

docker stop home-assistant || :
docker rm home-assistant || :

docker run -d --name="home-assistant" \
  -v /data/home-assistant:/config \
  -v /etc/localtime:/etc/localtime:ro \
  -restart=always \
  --net=host \
  homeassistant/home-assistant:stable
