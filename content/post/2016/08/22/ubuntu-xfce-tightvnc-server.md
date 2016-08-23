+++
author = "Shinpei Kawahito"
date = "2016-08-22T17:53:57+09:00"
draft = false
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
VNCサーバーからXcfeを起動するように設定を行います。

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
以下のコマンドで停止します。
```sh
$ vncserver -kill :1
```

### 自動起動の設定
#### 起動ファイルの作成
```sh
$ sudo vi /etc/systemd/system/vncserver@.service
```

```{{USERNAME}}```は環境に合わせて設定してください。

```sh
[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User={{USERNAME}}
PAMName=login
PIDFile=/home/{{USERNAME}}/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
```

#### 自動起動の設定
```sh
$ sudo systemctl daemon-reload
$ sudo systemctl enable vncserver@1.service
```

### 起動
以下のコマンドで手動で起動できるようになります。

```sh
$ sudo systemctl start vncserver@1
```

### ステータス確認
ステータスは以下のコマンドで確認します。

```sh
$ sudo systemctl status vncserver@1
```

### キーの設定
デフォルトのままだとキーがうまく効かないので編集します。  
```Applications``` > ```Settings``` > ```Window Manager``` > ```Keyboard```の設定を開きます。

#### Tabの設定
```Switch window for same application```を選択して、```Clear```することで、```Tab```キーが正常に動作するようになります。

{{<img_rel "tab.png">}}

