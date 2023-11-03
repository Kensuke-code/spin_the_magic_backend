# コマンド

- コンテナに入る
```
docker container exec -it spin_the_magic_backend-api-1 sh
```

- Railsコンソール
```
docker compose exec api rails c
```
- Redisサーバーに入る
```
docker exec -it spin_the_magic_backend-redis-1 /bin/bash

root@7942715bc049:/data# redis-cli
```