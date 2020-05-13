docker volume create caddy_data
docker volume create caddy_config

docker stop caddy || :
docker rm caddy || :

docker run \
  --name caddy \
  -d \
  --restart always \
  -p 80:80 -p 443:443 -p 2019:2019 \
  -v caddy_data:/data \
  -v caddy_config:/config \
  caddy:alpine \
  caddy run --resume
