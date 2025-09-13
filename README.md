# CoroutineとGeneratorの実験

## 目的

このリポジトリはプログラミング言語におけるcoroutineとgeneratorの実験を行うための環境を提供する。
環境はDockerで構築して、ユーザーの環境を問わずに実験が行えることを目指す

## 実験環境

- 歴史的な価値のあるプログラミング言語
  - [ipl-v](legacy_sample/iplv)
  - [simula](legacy_sample/simula)
  - [clu](legacy_sample/clu)
  - [icon](legacy_sample/icon)
- 現在のプログラミング言語
  - [c++](simple_sample/cpp)
  - [c#](simple_sample/cs)
  - [node.js](simple_sample/node)
  - [php](simple_sample/php)
  - [python](simple_sample/python)
  - [ruby](simple_sample/rb)

## 歴史的メモ

### coroutine
coroutineの概念はConwayが1958年に生み出したといわれます。
Conwayの[Design of a Separable Transition-Diagram Compiler](https://dl.acm.org/doi/10.1145/366663.366704)ではcoroutineを「特定のマスターがなく、同格の（コンパイルの処理を行う）サブルーチン同士が実行を譲り合いながら入出力をやり取りする自律的な処理単位」と説明しています。
また、Conwayは前述の論文中でJoel Erdwinnが同じ時期にcoroutineのアイディアを開発していたとあります。
残念ながら、Joel Erdwinnは"Bilateral Linkage,”という論文でコルーチンについて述べていたと考えられますが、現時点ではそれを確認することができません。

*参考：（[Art of Computer Programming, The: Volume 1: Fundamental Algorithms, 3rd Edition](https://www.oreilly.com/library/view/art-of-computer/9780321635754/)の「1.4.5. History and Bibliography」）*

この後、coroutineの概念を取り入れた高級プログラミング言語の１つはALGOL60を拡張する形で作成された[Simula](https://en.wikipedia.org/wiki/Simula)です。

Simulaについては本リポジトリで実験が可能です。


### generator

一方、generatorのの概念は1958年のIPL-Vに出てきます。IPL(Information Processing Language)はアセンブリ言語スタイルのプログラミング言語です。

- [An introduction to information processing language V](https://dl.acm.org/doi/10.1145/367177.367205)
- [INFORMATION PROCESSING LANGUAGE-V MANUAL](https://stacks.stanford.edu/file/druid:yz379pw9306/yz379pw9306.pdf)

TODO 執筆中

generatorの説明を読むと、これはスーパールーチンがジェネレータ


この研究用のプログラミング言語であるAlphardでは反復処理


|NAME|PQ |SYMB |LINK |COMMENTS|
|:---|:--|:----|:----|:---|
|J77 |   |J50  |     |Put test symbol in WO.|
|    |10 |9-10 |     |9-10をH0 に入れる|
|    |   |J100 |     |Input name of subprocess;name of list already in HO.Execute generator.|
|    |   |J5   |J30  |Result is H5+ if looked at all symbols in vain; reverse sign.|
|9-10|11 |WO   |    |WO Subprocess: input test symbol.|
|    |   |J2   |J5  |Test; reverse sign to stop generator if find symbol.|

|SYMB|説明|
|:---|:----|
|J77|TEST IF (0) IS ON LIST (1). Assume (1) is the name of a cell on a list. A search is done of all cells after (1); H5 is set + if (0) is found, and set - if not|
|J2|TEST IF (0) = (1). (The identity test is on the SYMB part only; P and Q are ignored.) |
|J5|REVERSE H5. If H5 is +, it is set-; if H5 is it is set +(H5を反転させる)|
|J3n|RESTORE WO, wl, ..., Wn. Ten routines, J30 through J39.|
|J5n|PRESERVE WO, wl, ..., Wn, THEN MOVE (0), (1) ..., (n) INTO WO, W1, ..., Wn, RESPECTIVELY Ten routines, J50 through J59, combining J4n and J2n.|
|J100|GENERATE SYMBOLS FROM LIST (1) FOR SUBPROCESS (0)<br>The subprocess named (0) is performed successively with each of the symbols of list named (1) as input. The order is the order on the list, starting with the first list cell. H5 is always set + at the start of the subprocess. J100 will move in list (1) if it is on auxiliary.|
