+++
author = "Shinpei Kawahito"
date = "2016-07-30T15:50:23+09:00"
draft = false
tags = ["seq2seq", "bot"]
title = "Seq2Seqモデルを用いたチャットボット作成 〜英会話のサンプルを動かす〜"
+++

最近、チャットボットが話題となっていますが、自然な会話を成り立たせること、は大きな課題の一つです。  
ここでは、Deep Learningの一種である、Seq2Seqモデルを用いて、チャットボットを動作させてみます。  
ゴールとして、英語を学習させ、実際に会話を行ってみることを目指します。

## Seq2Seq (Sequence to Sequence) モデルとは
{{<img_rel "seq2seq.png">}}

平たく言うと、ある文字列から、次の文字列を予測するモデルのことです。  
上記の図では、「ABC」を入力として、「WXYZ」を出力 (予測) しています。  

Seq2Seqモデルの対話タスクへの応用を試みたのがGoogleで、2015年に下記の論文を発表しています。

A Neural Conversational Model  
http://arxiv.org/abs/1506.05869

これまでの対話モデルは、ドメインを絞り (飛行機を予約するなど) 、手でルールを記載する必要があったが、Seq2Seqモデルを用いて対話データを学習させることで、自然な応答ができるようになった、と論文内で述べています。

## 実装例
Seq2Seqモデルを用いたチャットボットの実装は、色々な人が公開しています。  
https://github.com/nicolas-ivanov/seq2seq_chatbot_links  

今回は、実装例の中で、最も良い結果が出たとされている、以下のリポジトリのコードを動作させてみます。  
https://github.com/macournoyer/neuralconvo

## 環境構築
基本的には下記の手順で進めます。  
https://github.com/macournoyer/neuralconvo#installing  

筆者は下記の環境をベースに、追加で必要なLuaモジュールをインストールしました。  
[TorchをAWSのGPUインスタンス (Ubuntu 14.04) で動かす]({{ref "post/2016/08/03/torch-aws-gpu-ubuntu.md"}})

```
luarocks install nn
luarocks install rnn
luarocks install penlight
```

### データセットの準備
データセットは、下記で公開されている映画の台詞コーパスを用います。  
http://www.mpi-sws.org/~cristian/Cornell_Movie-Dialogs_Corpus.html

```
git clone https://github.com/macournoyer/neuralconvo.git
cd neuralconvo/data
wget http://www.mpi-sws.org/~cristian/data/cornell_movie_dialogs_corpus.zip
unzip cornell_movie_dialogs_corpus.zip
mv cornell\ movie-dialogs\ corpus cornell_movie_dialogs
```

## 学習
準備が整ったら学習をしてみます。
```
th train.lua --cuda --dataset 50000 --hiddenSize 1000
```

学習時間は4日弱で、エラー率の推移は下記となりました。

{{<img_rel "error.png">}}

## テスト
学習したモデルを用いて実際に会話をしてみました。

```
th eval.lua
```
>
__you>__ Hello?  
__neuralconvo>__ Hello, darling.
>
__you>__ How are you?  
__neuralconvo>__ I'm fine.
>
__you>__ Are you a machine?  
__neuralconvo>__ No, i don't.
>
__you>__ Are you intelligent?  
__neuralconvo>__ No.

それっぽい会話は成り立つようです。哲学的な質問をしてみます。

>
__you>__ What is the purpose of living?  
__neuralconvo>__ I've been watching over the phone thing...

うーん。深い...!?

## 評価
上記のように会話として成立するものもあれば、全く成り立たないケースもありました。

>
__you>__ What color is the sky?  
__neuralconvo>__ The other plate is currently in new york, in some kind of a tree in a decent, don

知識が足りないのはデータセットの不足で、文章として成立していないのは学習不足、といったところでしょうか。  
