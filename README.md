To run

```bash
docker run \
  --name "scripts" \
  --volume "/data/src/scripts:/src" \
  --workdir "/src" \
  --log-driver "json-file" \
  --log-opt max-file="3" \
  --log-opt max-size="10m" \
  --restart "always" \
  --network "private" \
  --env-file "/etc/geeebe/scripts.env" \
  --detach \
  --entrypoint "docker-entrypoint.sh" \
  node:14-buster \
  npm run start
```

To get docker run script from existing container

```bash
docker inspect --format "$(<run.tpl)" $name_or_id_of_running_container
```
