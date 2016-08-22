+++
author = "Shinpei Kawahito"
date = "2016-08-22T17:17:58+09:00"
draft = true
tags = ["development-environment"]
title = "Ubuntu 16.04 LTSにXcfeとTightVNC Serverでリモートデスクトップ環境を構築する"
+++

Macから [Vagrant](https://www.vagrantup.com/) 上の [Ubuntu (16.04 LTS)](https://atlas.hashicorp.com/bento/boxes/ubuntu-16.04) へリモートデスクトップでアクセスする手順をまとめます。

## デスクトップ環境のインストール
デスクトップ環境には高速な軽量なXfceを用います。(お好みに合わせてください)  
https://www.xfce.org/

```sh
$ sudo apt-get install -y xfce4 xfce4-goodies
```

## TightVNC Serverのセットアップ
リモートデスクトップを使用するため、TightVNCを用いてVNCサーバーを立てます。  
http://www.tightvnc.com/

### インストール
```sh
$ sudo apt-get install tightvncserver
```

### 起動設定
```sh
$ vi ~/.vnc/xstartup
```

```
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
```

### 起動
初回起動時には、アクセスする際のパスワードが求められるので入力します。  
view-only のパスワードは特に必要ないので、```n```を選択しました。

```sh
$ vncserver

You will require a password to access your desktops.

Password:
Verify:
Would you like to enter a view-only password (y/n)? n
...
```

### アクセス
MacのFinderから```移動``` > ```サーバーへ接続```で、VNCクライアントを起動します。  
アドレスバーには```vnc://[サーバーのIPアドレス]:5901```を入力してください。
{{<img_rel "vnc_client.png">}}

パスワードによる認証の後、リモートデスクトップにアクセスできます。

{{<img_rel "vnc_server.png">}}

### 停止
以下のコマンドで停止できます。
```sh
$ vncserver -kill :1
```
