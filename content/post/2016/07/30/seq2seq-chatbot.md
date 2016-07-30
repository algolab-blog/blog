+++
author = "Shinpei Kawahito"
date = "2016-07-30T15:50:23+09:00"
draft = false
tags = ["seq2seq", "bot"]
title = "Seq2Seqモデルを用いたチャットボット作成 〜英会話のサンプルを動かす〜"
+++

最近、チャットボットが盛り上がっていますが、自然な会話を成り立たせること、は大きな課題の一つです。  
本記事では、Deep Learningの一種である、Seq2Seq モデルを用いたアプローチをご紹介します。  
ゴールとして、Seq2Seqモデルを用いて、英会話を学習させ、動作させることを目指します。

## Seq2Seq (Sequence to Sequence) モデルとは
{{<img_rel "seq2seq.png">}}

平たく言うと、「文字列」から「文字列」を予測するモデルのことです。  
上記の図では、「ABC」を入力として、「WXYZ」を出力しています。  

2015年、Googleは、Seq2Seqモデルを対話タスクへ応用した論文を発表しました。

A Neural Conversational Model  
http://arxiv.org/abs/1506.05869

論文内において、これまでの対話モデルは、状況を絞り (飛行機を予約する状況など) 、手でルールを記載する必要があったが、Seq2Seqモデルを用いて対話データを学習させることで、自然な応答ができるようになった、と述べています。

## 実装例
Seq2Seqモデルを用いたチャットボットの実装は、色々な人が試みていますが、以下に良くまとめられています。  
https://github.com/nicolas-ivanov/seq2seq_chatbot_links  

今回は、実装例の中で、最も良い結果が出たとされている、以下のリポジトリのコードを動作させてみます。
https://github.com/macournoyer/neuralconvo

## 環境構築
### ソースコードのダウンロード
```
git clone https://github.com/macournoyer/neuralconvo.git
```

### Torchのインストール
Torchで実装されているので、公式に従って、インストールします。  
http://torch.ch/docs/getting-started.html  

```
git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch; bash install-deps;
./install.sh
source ~/.zshrc
```

### Luaライブラリのインストール
必要なLuaライブラリのインストール

```
luarocks install nn
luarocks install rnn
luarocks install penlight
luarocks install nn
luarocks install rnn
luarocks install penlight
```

### データセットの準備
データセットは、下記で公開されている映画台詞のコーパスを用います。
http://www.mpi-sws.org/~cristian/Cornell_Movie-Dialogs_Corpus.html

```
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

学習には AWSのg2.2xlargeインスタンスを用い、学習時間は4日弱でした。  
なお、エラー率の推移は下記となりました。

{{<img_rel "error.png">}}

## テスト 
最後に会話をしてみましょう。

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

それっぽい会話は成り立つようです。最後に、哲学的な質問をしてみました。

>
__you>__ What is the purpose of living?  
__neuralconvo>__ I've been watching over the phone thing...

うーん。深い...。


