docker stop scripts || :
docker rm scripts || :

docker run \
  --name scripts \
  -d \
  --restart always \
  -v /data/src/scripts:/src \
  --workdir /src \
  -p 55891:55891 \
  node:14-buster \
  npm run start
