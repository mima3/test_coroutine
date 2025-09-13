# Simula動作環境

[Cim](https://www.gnu.org/software/cim/)を使用した[Simula](https://en.wikipedia.org/wiki/Simula)の実験環境

## ビルドとコンテナ起動

```bash
docker compose build --no-cache
docker compose up -d

# 終了したい時
docker compose down
```

## Simulaのプログラムの実行方法

```bash
docker compose run --rm simula sh -lc 'gnucim ./coroutine_01.sim -o coroutine_01 && ./coroutine_01'

docker compose run --rm simula sh -lc 'gnucim ./coroutine_02.sim -o coroutine_02 && ./coroutine_02'
```
