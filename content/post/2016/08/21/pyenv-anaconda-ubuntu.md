+++
authors = "kawahito"
date = "2016-08-21T17:22:48+09:00"
draft = false
tags = ["development-environment", "ubuntu"]
title = "pyenv + Anaconda (Ubuntu 16.04 LTS) で機械学習のPython開発環境をオールインワンで整える【随時更新】"
+++

筆者の機械学習系のPython開発環境は、[Vagrant](https://www.vagrantup.com/) を用いた [Ubuntu (16.04 LTS)](https://atlas.hashicorp.com/bento/boxes/ubuntu-16.04) 上に構築しています。  
ここでは、画像認識、音声認識、自然言語処理などに必要な環境をオールインワンで構築する手順をまとめます。  
(最終更新日: 2016/08/22)

## OSバージョン
OSバージョンは下記の通りです。  
```sh
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.1 LTS"
```
```sh
$ uname -a
Linux vagrant 4.4.0-31-generic #50-Ubuntu SMP Wed Jul 13 00:07:12 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
```

## pyenv + Anaconda の環境を構築
Python環境は、pyenv + Anacodaを用いて構築します。  
pyenvやAnacondaの概要やメリットについては、下記の記事に詳しくまとまっています。  
[データサイエンティストを目指す人のpython環境構築 2016](http://qiita.com/y__sama/items/5b62d31cb7e6ed50f02c)

上記の記事にあるように、ここでもpyenvはAnacondaのインストーラとしてのみ使用し、Python環境の切り替えはAnacondaで行うこととします。

### 必要なパッケージのインストール
まず、必要なパッケージをインストールします。
```sh
$ sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev
```

### pyenvのインストール
pyenvおよびプラグインをインストールし、環境を整えます。
```sh
$ git clone git://github.com/yyuu/pyenv.git ~/.pyenv
$ git clone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
$ echo 'eval "$(pyenv init -)"' >> ~/.bashrc
$ source ~/.bashrc
```

### Anacondaのインストール
まず、最新のAnaconda (Python 3系) のバージョンを確認します。
```sh
$ pyenv install -l | grep anaconda3
  anaconda3-2.0.0
  anaconda3-2.0.1
  anaconda3-2.1.0
  anaconda3-2.2.0
  anaconda3-2.3.0
  anaconda3-2.4.0
  anaconda3-2.4.1
  anaconda3-2.5.0
  anaconda3-4.0.0
  anaconda3-4.1.0
```

最新のAnaconda (ここでは4.1.0) をインストールし、デフォルトとして設定します。
```sh
$ pyenv install anaconda3-4.1.0
$ pyenv global anaconda3-4.1.0
$ echo 'export PATH="$PYENV_ROOT/versions/anaconda3-4.1.0/bin/:$PATH"' >> ~/.bashrc
$ source ~/.bashrc
```

Pythonの環境を確認します。
```sh
$ python --version
Python 3.5.1 :: Anaconda 4.1.0 (64-bit)
```

## Pythonライブラリのインストール
以下、用途に応じて必要なPythonライブラリ (+ 本体) をインストールしていきます。  
``conda``経由が便利なものは``conda``で、それ以外は``pip``で行います。

諸々インストールする前に自身を更新しておきます。
```sh
$ conda update -y conda
$ pip install --upgrade pip
```

## 深層学習ライブラリ
### TensorFlow
Googleの深層学習ライブラリ。``conda``経由で最新バージョンを一発でインストールします。  
https://www.tensorflow.org/

```sh
$ conda install -y -c jjhelmus tensorflow
```

### Chainer
PFNの深層学習ライブラリ  
http://chainer.org/
```sh
$ pip install chainer
```

### Keras
TensorFlowおよびTheanoのラッパー。同時にTheanoも入ります。  
https://keras.io/

```sh
$ pip install keras
```

## 画像認識
### ImageMagick
画像処理ライブラリ。``conda``経由で本体もまとめてインストールします。  
http://imagemagick.org/script/index.php

```sh
$ conda install -y -c kalefranz imagemagick
```
### OpenCV
コンピュータビジョンライブラリ  
http://opencv.org/

```sh
$ conda install -y -c menpo opencv3
```
### Dlib
画像処理系が充実している機械学習ライブラリ。```cmake```と```boost-python```も同時にインストールします。  
http://dlib.net/
```sh
$ sudo apt-get install libboost-python-dev cmake
$ conda install -y -c wordsforthewise dlib
```

### Selective Search
Alpacaが提供しているSelectiveSearchに特化したライブラリ  
https://github.com/AlpacaDB/selectivesearch

```sh
$ pip install selectivesearch
```

## 音声認識
### FFmpeg
音声・動画処理ライブラリ。Ubuntu16.04から本体は``apt-get``で入るようになりました。  
https://ffmpeg.org/

```sh
$ sudo apt install -y ffmpeg
$ pip install ffmpy
```

## 自然言語処理
### MeCab
形態素解析エンジン。本体は``apt-get``でインストールします。  
http://taku910.github.io/mecab/

```sh
$ sudo apt-get -y install libmecab-dev mecab mecab-ipadic mecab-ipadic-utf8
$ pip install mecab-python3
```
### gensim
トピックモデルのライブラリ  
https://radimrehurek.com/gensim/

```sh
$ pip install gensim
```

## 強化学習
### OpenAI Gym
強化学習のトレーニング環境  
https://gym.openai.com/
```sh
$ pip install gym
```

## その他便利ツール
### TightVNC Server
リモートデスクトップ環境。下記の記事を参照してください。  
[Ubuntu 16.04 LTSにXcfeとTightVNC Serverでリモートデスクトップ環境を構築する]({{<ref "post/2016/08/22/ubuntu-tightvnc-server.md">}})
