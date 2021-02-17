set -e

sudo docker volume create caddy_data
sudo docker volume create caddy_config

sudo docker stop caddy || :
sudo docker rm caddy || :

sudo mkdir -p /etc/caddy
sudo touch /etc/caddy/Caddyfile

sudo docker run \
  --name caddy \
  -d \
  --restart always \
  --network host \
  -v /etc/caddy/Caddyfile:/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  -v caddy_config:/config \
  caddy:alpine \
  caddy run --config /etc/caddy/Caddyfile
