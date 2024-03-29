set -e

sudo mkdir -p /etc/cloudflared
sudo chown -R 65532:root /etc/cloudflared

function cf_login {
  sudo docker run \
    --rm \
    --network host \
    -v /etc/cloudflared:/home/nonroot/.cloudflared \
    cloudflare/cloudflared:2022.1.0 \
    tunnel login
}

function cf_exec {
  sudo docker run \
    --rm \
    --network host \
    -v /etc/cloudflared:/home/nonroot/.cloudflared \
    cloudflare/cloudflared:2022.1.0 \
    tunnel $@
}

[[ ! -f /etc/cloudflared/cert.pem ]] && cf_login || :

[[ ! -z "$*" ]] && echo "cloudflared tunnel $@" && cf_exec $@ && exit 0

sudo docker stop cloudflared || :
sudo docker rm cloudflared || :

sudo docker run \
  --name cloudflared \
  -d \
  --restart always \
  --network host \
  -v /etc/cloudflared:/home/nonroot/.cloudflared \
  cloudflare/cloudflared:2022.1.0 \
  tunnel run
