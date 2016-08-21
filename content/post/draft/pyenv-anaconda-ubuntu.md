+++
author = "Shinpei Kawahito"
date = "2016-08-19T17:00:54+09:00"
draft = true
tags = ["環境構築"]
title = "【随時更新】Pyenv + Anaconda (Ubuntu 14.04) で機械学習のPython開発環境をオールインワンで整える"
+++

筆者は普段Macを使っていますが、機械学習系の開発は、[Vagrant](https://www.vagrantup.com/) を用いてUbuntu (14.04) の仮想環境を構築し、その上にPython環境を整えています。  
まとめます。


## 必要なパッケージをまとめてインストール
```sh
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev swig
```

## Pyenv + Anaconda の環境を構築
Python環境にはPyenv + Anacodaを用いています。

[データサイエンティストを目指す人のpython環境構築 2016](http://qiita.com/y__sama/items/5b62d31cb7e6ed50f02c)


### Pyenv
```sh
git clone git://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
```

### Anaconda
最新のAnacondaを確認
```sh
pyenv install -l | grep anaconda

```


```sh
pyenv install anaconda3-2.5.0
pyenv global anaconda3-2.5.0
```

## Pythonライブラリのインストール
以下、用途に応じて必要なPythonライブラリをインストールします。  
``conda``で入るものは``conda``で、それ以外は``pip``で行います。


### 汎用系
```sh
# flake8
conda install flake8
```

### 機械学習フレームワーク
```sh
# TensorFlow
```

### 画像認識
```sh
# OpenCV
conda install -c menpo opencv3
# dlib
conda install -c menpo dlib
```

### 音声認識

### 自然言語処理

### 強化学習
```sh
# OpenAI Gym
# https://gym.openai.com/
pip install gym

```
