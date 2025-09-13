# ICONの実行環境

[icon](https://www2.cs.arizona.edu/icon/)の実験環境をdockerで構築する

## ビルドとコンテナ起動

```bash
docker compose build --no-cache
docker compose up -d

# 終了したい時
docker compose down
```

## ICONのプログラムの実行方法

```bash
docker compose run --rm icon sh -lc 'icont -o gen gen.icn && ./gen'
```
