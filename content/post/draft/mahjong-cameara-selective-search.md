+++
author = "Shinpei Kawahito"
date = "2016-08-17T15:28:18+09:00"
draft = true
tags = ["image-recognition", "product"]
title = "麻雀カメラプロジェクト再始動？ 〜dlib + Selective Search (R-CNN) で牌検出を試みる〜"
+++

2014年の終わり頃に「麻雀カメラ」というiPhoneアプリを作っていました。  
カメラをかざすだけで麻雀の得点計算を行ってくれるアプリです。

{{<youtube "livDDcygEDU">}}

動画を見ていただければ一目瞭然ですが、さすがに実用では使えない、ということでお蔵入りしました...。  
(時間がかかるだけでなく、精度もあまり良くありませんでした。)  

あれから一年半、技術の進歩は目覚ましく、いまならば良いものが作れるのでは？と思い立ち、再挑戦してみることにしました。

## 麻雀牌判定プロセス
画像に何が写っているか判定するためには、大きく「検出 (Detection)」と「認識 (Recognition)」というプロセスに分かれます。

### 検出
物体が画像内のどこにあるかを判定するプロセス。  
下記の画像でいうと、赤枠をつけていくイメージです。

{{<img_rel "detection.png">}}

### 認識
検出された領域に写っている物体が何であるかを判定するプロセス。  
具体的には、下記の物体が「五萬」である、と判定することを言います。

{{<img_rel "recognition.png">}}

## 当時用いていたアルゴリズム
以下のように、古典的な手法で判定を行っていました。

詳細なプロセスは下記の通りです。

1. カメラの画像を二値化する
1. 二値化画像から、輪郭を抽出する
1. 抽出した輪郭を、頂点数や領域サイズの条件で絞りこむ
1. 絞りこんだ輪郭の外接矩形を手牌領域とみなす
1. 手牌領域に対し、テンプレートマッチングを行う
1. スコアが一番高い領域・牌を確定させる
1. 確定した箇所を除き、テンプレートマッチングを繰り返す
1. スコアが閾値を超えなくなったら終了

## Selective Search
DeepLearning界隈では、物体検出

## dlibのインストール
Pythonライブラリが公開されているので、インストールします。  
筆者はPython環境にAnacondaを用いているので、```conda```経由でインストールを行いました。

```sh
conda install -c wordsforthewise dlib
```

なお、Anaconda環境の構築については下記にまとめていますので、ご参照ください。  
[【随時更新】pyenv + Anaconda (Ubuntu 16.04 LTS) で機械学習のPython開発環境をオールインワンで整える]({{<ref "post/2016/08/21/pyenv-anaconda-ubuntu.md">}})

## dlibのサンプルを動かす
```sh
$ git clone https://github.com/davisking/dlib.git
$ cd dlib
$ python python_examples/face_detector.py examples/faces/2007_007763.jpg 
Processing file: examples/faces/2007_007763.jpg
Number of faces detected: 7
Detection 0: Left: 93 Top: 194 Right: 129 Bottom: 230
Detection 1: Left: 193 Top: 90 Right: 229 Bottom: 126
Detection 2: Left: 293 Top: 86 Right: 329 Bottom: 122
Detection 3: Left: 157 Top: 114 Right: 193 Bottom: 150
Detection 4: Left: 177 Top: 214 Right: 213 Bottom: 250
Detection 5: Left: 381 Top: 89 Right: 424 Bottom: 132
Detection 6: Left: 309 Top: 233 Right: 352 Bottom: 276
Hit enter to continue
```

領域
Faster R-CNN
