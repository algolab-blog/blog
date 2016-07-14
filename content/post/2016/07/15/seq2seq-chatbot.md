+++
author = "Shinpei Kawahito"
date = "2016-07-15T15:50:23+09:00"
draft = true
post = true
tags = ["seq2seq", "bot"]
title = "Seq2Seq モデルを用いたチャットボット作成 〜 英会話のサンプルを動かす"

+++

最近、チャットボットが盛り上がっていますが、自然な会話を成り立たせること、は大きな課題の一つです。  
本記事では、Deep Learning の一種である、Seq2Seq モデルを用いたアプローチをご紹介します。  
ゴールとして、Seq2Seq モデルを用いて、英会話を学習させ、動作させることを目指します。

## Seq2Seq (Sequence to Sequence) モデルとは
{{< figure src="/images/2016/07/15/seq2seq-chatbot/seq2seq.png" >}}

平たく言うと、「文字列」から「文字列」を予測するモデルのことです。  
上記の図では、「ABC」を入力として、「WXYZ」を出力しています。  


Sequence to Sequence Learning with Neural Networks  
https://arxiv.org/abs/1409.3215

## Seq2Seq モデルの対話タスクへの応用
2015 年に Google が発表した下記の論文が有名です。  

A Neural Conversational Model  
http://arxiv.org/abs/1506.05869

これまで、

映画のセリフを学習させ、


## 実装例
以下に大変良くまとめられています。  
https://github.com/nicolas-ivanov/seq2seq_chatbot_links  

今回は、上記実装例の中で、最も良い結果が出たとされている、  
https://github.com/macournoyer/neuralconvo

> Probably the best results currently achieved with an open-sourced Seq2seq implementation

## データセット

http://www.mpi-sws.org/~cristian/Cornell_Movie-Dialogs_Corpus.html

## 環境構築
### Torch のインストール

http://torch.ch/docs/getting-started.html


```
git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch; bash install-deps;
./install.sh
```

### 学習
```
th train.lua --cuda --dataset 50000 --hiddenSize 1000
```

学習には AWS の g2.2xlarge インスタンスを用い、学習時間は 4 日弱でした。
エラー率の推移は下記となります。

## 評価
最後に会話をしてみます。

```
th eval.lua
```


## 参考
* A Neural Conversational Model
 - http://arxiv.org/abs/1506.05869

* Sequence to Sequence Learning with Neural Networks  
 - https://arxiv.org/abs/1409.3215

* Sequence-to-Sequence Models
 - https://www.tensorflow.org/versions/master/tutorials/seq2seq/index.html
