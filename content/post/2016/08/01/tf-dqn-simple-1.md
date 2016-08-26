+++
authors = "kawahito"
date = "2016-08-01T22:06:25+09:00"
draft = false
tags = ["reinforcement-learning", "dqn", "tensorflow"]
title = "超シンプルにTensorFlowでDQN (Deep Q Network) を実装してみる 〜導入編〜"
+++

みなさん、DQNしてますか？  
DQNについては、下記の記事によくまとめられており、実装してみようとした方も多いのではないでしょうか。

* [DQNの生い立ち　＋　Deep Q-NetworkをChainerで書いた](http://qiita.com/Ugo-Nama/items/08c6a5f6a571335972d5)  
* [ゼロからDeepまで学ぶ強化学習](http://qiita.com/icoxfog417/items/242439ecd1a477ece312)  

しかし、いざ自力で動作させてみようとすると、こんな問題にぶち当たると思います。

「学習時間なげえ。。。」

DQNに限らず、ディープラーニングのモデルを学習させようとすると、平気で数日以上かかります。  
そして、学習させたモデルが期待通りの動作をしなかったとしたら、もう投げ出したくなってしまいます。  
(よくある話です)

なので、筆者が新しいモデルを一から実装する際には、なるべく単純なモデル、データから始めるようにしています。

ここでは、超シンプルなDQNを実装し、動作させてみることにします。  
早速いってみましょう。CPUで3分もあれば学習が終わります！

## まずは動かしてみよう
{{<img_rel "demo-catch_ball.gif">}}

### 概要
具体的には、上図のように上から落ちてくるボールをキャッチする、というタスクを学習させます。  
TensorFlowで実装しており、ソースコードは下記に公開しています。  
https://github.com/algolab-inc/tf-dqn-simple


### 環境構築
はじめにソースコードをダウンロードします。
```sh
$ git clone https://github.com/algolab-inc/tf-dqn-simple.git
```

次に、動作のためにTensorFlowとMatplotlibが必要なので、インストールします。

Tensorflowについては下記リンクを参照のうえインストールを行ってください。  
https://www.tensorflow.org/versions/master/get_started/os_setup.html  
(2016/08/01現在、Python3.5.2 + Tensorflow0.9.0での動作を確認しています)

Matolotlibはpipでインストールします。
```sh
$ pip install matplotlib
```

### 学習

環境が整ったら、ソースコードのディレクトリに移動して、train.pyを叩くと学習が始まります。
```sh
$ cd tf-dqn-simple
$ python train.py
```

下記のようなログが出ていれば、正しく学習が行われています。

> EPOCH: 000/999 | WIN: 001 | LOSS: 0.0068 | Q_MAX: 0.0008  
EPOCH: 001/999 | WIN: 002 | LOSS: 0.0447 | Q_MAX: 0.0013  
...

数分ほどで学習が終わったかと思います。  
では学習したモデルでテストしてみましょう。

```sh
$ python test.py
```

> WIN: 001/001 (100.0%)  
WIN: 002/002 (100.0%)  
...

キャッチボールのアニメーションとともに、上記のようなログが出れば成功です。  
きちんと動作しましたでしょうか？  
学習がうまくいっていれば、おそらく100%でキャッチできていると思います。

次回は、実装編についてお届けします。
