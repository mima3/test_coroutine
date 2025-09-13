
# コルーチンの実装サンプル

## 起動方法

```bash
# 開始
docker compose up -d
# やめる
docker compose down
```

### Ruby

```bash
docker compose run --rm ruby ruby /app/generator.rb
docker compose run --rm ruby ruby /app/coroutine.rb
docker compose run --rm ruby ruby /app/transfer.rb
```

### PHP

```bash
docker compose run --rm php php fibers.php
docker compose run --rm php php generator.php
```

### C++23

```bash
docker compose run --rm cpp bash /app/coroutine.sh
docker compose run --rm cpp bash /app/transfer.sh
```

### Python

```
docker compose run --rm python python /app/generator01.py
docker compose run --rm python python /app/coroutine.py
```

### node

```bash
docker compose run --rm node node /app/generator.js
docker compose run --rm node node /app/coroutine.js
```

### CSharp

```bash
docker compose run --rm dotnet dotnet-script /app/generator.csx
docker compose run --rm dotnet dotnet-script /app/coroutine.csx
```