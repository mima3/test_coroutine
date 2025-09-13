
# 　CLU動作環境

[pclu](https://github.com/nbuwe/pclu.git)を使用した[CLU](https://en.wikipedia.org/wiki/CLU_(programming_language))の実験環境の構築。

## ビルドとコンテナ起動

```bash
cd legacy_sample/clu
docker compose build --no-cache
docker compose up -d

# 終了したい時
docker compose down
```

## CLUのプログラム実行方法


```bash
docker compose run --rm clu bash
# 以降、コンテナ内
# コンパイル
pclu -opt -co /work/iter_demo.clu
# リンク
plink -opt -o  /work/iter_demo  /work/iter_demo.o
# 実行
/work/iter_demo
```

＊iter_demo.cluに日本語は入れないほうが良さそう。
