docker stop scripts || :
docker rm scripts || :

docker run \
  --name scripts \
  -d \
  --restart always \
  --network private \
  -v /data/src/scripts:/src \
  --workdir /src \
  node:14-buster \
  npm run start
