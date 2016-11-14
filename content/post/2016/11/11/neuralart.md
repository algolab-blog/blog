+++
date = "2016-11-11T18:47:53+09:00"
draft = false
tags = [
  "image-recognition",
  "tensorflow"
]
title = "TensorFlowで画風変換を試す"
authors = "kawahito"
+++

{{<img_rel "animation.gif">}}

TensorFlowを用いて画風変換を試してみました。上記画像は学習過程となります。  
GitHubで「neuralart」と検索すると実装例がいくつか出てきますので、そのうちの一つを動作させてみます。  
https://github.com/ckmarkoh/neuralart_tensorflow

なお、環境構築については下記の記事をご参照ください。Python2系での動作を確認しています。  
[【随時更新】pyenv + Anaconda (Ubuntu 16.04 LTS) で機械学習のPython開発環境をオールインワンで整える]({{ref "post/2016/08/21/pyenv-anaconda-ubuntu.md"}})

## ソースコードをダウンロード
```sh
$ git clone https://github.com/ckmarkoh/neuralart_tensorflow.git
```

## 訓練済み画像認識モデルをダウンロード
下記URLからVGG-19モデルをダウンロードし、`neuralart_tensorflow`直下に配置します。
https://drive.google.com/file/d/0B8QJdgMvQDrVU2cyZjFKU1RrLUU/view

## 画風変換
以下で画風変換のイテレーションが始まります。元画像とスタイル画像は下記の通りとなります。
```sh
$ python main.py
```
元画像
{{<img_rel "Taipei101.jpg">}}

スタイル画像
{{<img_rel "StarryNight.jpg">}}

結果は`results`フォルダに格納されていきます。  
なお、筆者の環境では、CPUマシンで100イテレーションあたり1時間弱かかりました。

## 学習過程を可視化
900イテレーションまでの結果画像をImageMagickを用いてアニメーションGIFにしてみます。  
（冒頭で紹介した画像となります）
```sh
$ cd results
$ convert -delay 50 -loop 0 0*00.png animation.gif
```

## 論文
画風変換の元となる論文はこちらです。  
[A Neural Algorithm of Artistic Style](https://arxiv.org/abs/1508.06576)
