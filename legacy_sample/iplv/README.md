# IPL-Vの動作環境

Lispで実装された[IPL-V](https://github.com/jeffshrager/IPL-V/tree/main)のエミュレータ

## オリジナルとの差

J100の呼び出したサブルーチンでH5に-が設定されたら操作を中断するようにしています。

パッチとして以下を適用しています。

- src/j100-h5-stop.patch

これは以下の資料でそう解釈しました。

[INFORMATION PROCESSING LANGUAGE V MANUAL Section II. Programmers' Reference 1960 p51](https://iiif.library.cmu.edu/file/Newell_box00003_fld00181_doc0001/Newell_box00003_fld00181_doc0001.pdf)

>J100 GENERATE SYMBOLS FROM LIST (l) FOR 8UBPROCESS (0). The subprocess named (0) is performed successively with each of the symbols of list named (l) as input. The order is the order on the list, starting with the first list cell. H5 is safe over the generator: The sign of H5 left by the subprocess at one occurrence will exist at the next occurrence (it must be 4- to keep the generator going).

[INFORMATION PROCESSING LANGUAGE-V MANUAL 1964](https://stacks.stanford.edu/file/druid:yz379pw9306/yz379pw9306.pdf)の「9.0 GENERATOR CONSTRUCTION」中のJ100のコードで行っている処理

>J100 is the simplest of generators; let us examine
how it is constructed. Basically, of course, it consists
of a loop to go down the list. But it must have some
place to keep both the location in the list and the name
of the subprocess while the subprocess is working. Likewise, it must be sure that it doesn't destroy any of the
information used by the subprocess. To see this problem
clearly, suppose we code J100 as follows, which seems
perfectly straightforward:

|NAME|PQ|SYMB|LINK|COMMENTS|
|:---|:---|:---|:---|:---|
|JJlOOlO| |J5l||Put subp subprocess in WO, list
name in Wl, push down W's.|
|9-2 |11|W1||Input location on list.|
|       |  |J6O| |Locate next. 20 W1 Put back in W1 prior to branch. |
|    |70|9-1|||
|    |12|W1||Input symbol in cell of list for subprocess.|
|    |01|W0||Execute subprocess (P=0, Q-1) .|
|    |70|J3l|9-2|If subprocess returns H5-, quit with H5-.|
|9-1 |  |J4|J3l|If went to end of list,quit with Hs+.|

## ビルドとコンテナの起動

```bash
docker compose build --no-cache
docker compose up -d

# 終了したい時
docker compose down
```

## プログラムの実行方法

lispの起動

```bash
# Lispでipl-vの実験を開始
docker compose run --rm iplv --dynamic-space-size 2048 --load /app/iplv.lisp

or 

# コンテナに入る
docker compose run --rm --entrypoint '' iplv bash
# Lisp起動
sbcl --dynamic-space-size 2048 
# IPL-Vのモジュールをロード
(load "/app/iplv.lisp")
```

lisp起動後にipl-v用のコードを実行する

```bash
# 付属のサンプル
(load-ipl "misccode/F1.liplv" :adv-limit 80000)
# 足し算の例
(load-ipl "/src/test_01.liplv" :adv-limit 80000)
# generatorの例
(load-ipl "/src/test_02.liplv" :adv-limit 80000)
```


## デバッグ方法

**詳細なログの出力方法**

```lisp
(setf *default-!!list* '(:run :jfns :jdeep :jcalls))
(set-trace-mode :default)
(load-ipl "/src/test_02.liplv" :adv-limit 80000)
```

**シンボルの登録状況の確認**

```
(maphash (lambda (k v)
           (format t "~&~S => ~S~%" k v))
         *symtab*)
```
