+++
tags = [
  "speech-recognition",
  "openfst"
]
title = "重み付き有限状態トランスデューサ (WFST) をOpenFstで作成する"
authors = "kawahito"
date = "2016-09-13T20:00:03+09:00"
draft = false
+++

音声認識などの分野では、重み付き有限状態トランスデューサ (WFST) が今でも広く用いられています。  
ここではOpenFstを用いて簡単なサンプルを作成してみます。  
http://www.openfst.org

## 有限状態トランスデューサ (FST: Finite-State Transducer)
FSTというと一見小難しいですが、簡単に言えば、入力記号列に対して出力記号列を返す変換器です。  
一番単純な例からみてみましょう。下図をご覧ください。

{{<img_rel "fst_1.png">}}

これは``a``の入力に対して``A``を返すFSTです。詳しく見ていきます。

{{<img_rel "fst_2.png">}}

まず、初期状態から始まり、最終状態に遷移できたもののみ出力を行う、という制約があります。  
そして、遷移の条件が``入力:出力``という形で表現されます。  
上記の例では``a``以外の入力は受け付けないこととなります。

少し複雑になった例をみてみましょう。

{{<img_rel "fst_3.png">}}

これは``ab``の入力に対して``AB``を、``ba``の入力に対して``BA``を出力します。  
例えば、``ab``の入力に対しては、``0`` &rarr; ``1`` &rarr; ``2`` と遷移できるので、``AB``を出力することになります。

## 重み付き有限状態トランスデューサ (WFST: Weighted Finite-State Transducer)
FSTに重みを加えたものがWFSTとなります。

{{<img_rel "wfst.png">}}

``/``以下の数値が重みを表し、WFSTは記号列と重みを出力します。  
例えば``ab``の入力に対しては、``AB``とともに重み``4.5 (= 0.5 + 1.5 + 3.0)``を出力ことになります。

## OpenFst
それではOpenFstを用いて実際にWFSTを作成してみましょう。

### インストール
ダウンロード及びインストール方法については下記の公式ドキュメントをご参照ください。  
http://www.openfst.org/twiki/bin/view/FST/FstDownload

筆者の環境では、Kaldiの導入時に同時にインストールを行いました。  
[Kaldiで音声を学習させる 〜ディープラーニングを用いた音声認識ツールキット〜]({{<ref "post/2016/08/31/kaldi.md">}})

以下のコマンドが叩ければ正常にインストールが完了しています。
```sh
$ fstcompile --help
```

### WFST作成
ここからは下記のリンクを参考に進めます。

http://www.openfst.org/twiki/bin/view/FST/FstQuickTour
http://kaldi-asr.org/doc/tutorial_looking.html

具体的には下図に示すWFSTを作成してみます。

{{<img_rel "binary.png">}}

FSTファイルはテキストで表現できます。下記のように定義していきます。

```sh
# arc format: src dest ilabel olabel [weight]
# final state format: state [weight]
# lines may occur in any order except initial state must be first line
# unspecified weights default to 0.0 (for the library-default Weight type)
$ cat >text.fst <<EOF
0 1 a x .5
0 1 b y 1.5
1 2 c z 2.5
2 3.5
EOF
```

入力記号列は内部的には数値で表現するため、その定義を行います。``<eps>``は空を表します。

```sh
$ cat >isyms.txt <<EOF
<eps> 0
a 1
b 2
c 3
EOF
```

同様に出力記号列の定義も行います。

```sh
$ cat >osyms.txt <<EOF
<eps> 0
x 1
y 2
z 3
EOF
```

バイナリ形式にコンパイルします。
```sh
$ fstcompile --isymbols=isyms.txt --osymbols=osyms.txt text.fst binary.fst
```

これでWFSTが作成できました。

### WFSTの演算
上記は簡単な例ですが、様々なモデルをWFSTで表現することができます。  
そして、WFST形式で表現すると、各種演算が可能になるというメリットがあります。

簡単な演算をしてみましょう。2つのWFSTを合成する演算してみます。

```sh
$ fstcompose binary.fst binary.fst binary2.fst
```

テキスト形式で確認してみます。

```sh
$ fstprint --isymbols=isyms.txt --osymbols=osyms.txt binary2.fst
0 1 a x 1
0 1 b y 3
1 2 c z 5
2 7
```

元に比べて重みが倍になっていることがわかります。  
また、[Graphviz](http://www.graphviz.org) で操作可能なdot形式で出力することもできます。

```sh
$ fstdraw --isymbols=isyms.txt --osymbols=osyms.txt binary2.fst binary2.dot
```

Graphvizがインストールされている場合は、下記コマンドでpngに形式に出力することができます。
```sh
$ dot -Tpng binary2.dot > binary2.png
```

以下の画像が出力されました。
{{<img_rel "binary2.png">}}

その他詳しい操作については公式ドキュメントをご参照ください。  
http://www.openfst.org/

