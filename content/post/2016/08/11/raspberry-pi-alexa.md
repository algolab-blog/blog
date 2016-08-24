+++
authors = "kawahito"
date = "2016-08-11T19:08:44+09:00"
draft = false
tags = ["speech-recognition"]
title = "Amazon Echoを6,000円で自作する 〜Raspberry Pi 3 + Alexa Voice Services (AVS)〜"
+++

[音声は新しいパラダイムシフトになる 〜2016年度版メアリー・ミーカー氏レポートまとめ〜]({{<ref "post/2016/07/29/mary-meeker-2016.md">}}) でも触れたように、次世代デバイスとしてAmazon Echoは注目するべき存在です。  

しかしながら、日本では技適の関係で未だ使用できません。  
ただ、Alexa Voice Services (AVS) というものが公開されており、Amazon Echoを様々なデバイスで動作させることが可能です。

今回は、Raspberry Pi 3からAVSを利用できるようにしました。  
セットアップについては下記にある通りですが、低予算での最低限の手順をまとめてみます。
https://github.com/amzn/alexa-avs-raspberry-pi

## 完成したもの
いきなり動画ですが、こんな感じで動きます。英語で話かけると、リクエストを解釈して実行してくれたり、音声で応答してくれて面白いです。
{{<youtube fWubPL5_YaU>}}

## 用意したもの
音声入力にUSBマイクロフォンが必要なので、Raspberry Pi 3と併せて購入。他はありあわせで用意しました。  
Raspberry Pi用のディスプレイを用意してもよいですが、今回はVNC server (Linux版リモートデスクトップ) を使います。

### 買ったもの
- Raspberry Pi 3 (4,800円)
 - https://www.amazon.co.jp/gp/product/B01D1FR2WE/
- USBマイクロフォン (1,600円)
 - https://www.amazon.co.jp/gp/product/B0027WPY82

### ありあわせ
- Micro SDカード
 - https://www.amazon.co.jp/dp/B00CDJNOX6/
- Micro-USB (A-MicroB) ケーブル
- スピーカー
- LANケーブル

## Raspberry Pi を起動する
### OSイメージの準備
以下の記事を参考に進めました。  
[Raspberry Pi 3にRaspbianをインストール(Mac OS X を使用)](http://qiita.com/onlyindreams/items/acc70807b69b43e176bf)

* Rasbian Jessie は ```2016-05-27``` リリースのものを用いました。
* ddコマンドのオプションで、ブロックサイズを大文字 (```bs=1M```) で指定

### 起動手順
1. MicroSD、LAN、 USBマイクロフォン、スピーカーを接続しておきます。
1. 電源用としてUSBケーブルを挿すとBIOSが起動します。今回はOSであるRaspbian Jessieも自動で起動しました。

## 必要なアカウント・ライブラリの準備
AVSを利用するために必要なものを諸々準備します。

### Amazon Developer アカウントの登録
下記よりアカウントを登録します。登録済みであれば不要です。  
https://developer.amazon.com/login.html

### サンプルアプリのダウンロード
公式のGithub上にある [Sample app](https://github.com/amzn/alexa-avs-raspberry-pi/archive/master.zip) をダウンロード&解凍して下記のようにデスクトップなどのパスに保存します。
```sh
/home/pi/Desktop/alexa-avs-raspberry-pi-master/
```

### VNC Serverのインストール

```sh
# install
$ sudo apt-get install tightvncserver
# run
$ tightvncserver
# auto run setup
$ vi /home/pi/.config/tightvnc.desktop
```
tightvnc.desktop
```sh
[Desktop Entry]
Type=Application
Name=TightVNC
Exec=vncserver :1
StartupNotify=false
```

### VLCのインストール
VLC media playerをインストールします。

```sh
# install
$ sudo apt-get install vlc-nox vlc-data
# add env vars
$ echo "export LD_LIBRARY_PATH=/usr/lib/vlc" >> ~/.bashrc
$ echo "export VLC_PLUGIN_PATH=/usr/lib/vlc/plugins" >> ~/.bashrc
$ soure ~/.bashrc
```

### NodeとNPMのインストール
後に出てくるサーバーの起動に必要なNodeとNPMをインストールします。

```sh
# apt-get update & upgrade. It takes about 15 min.
$ sudo apt-get update && sudo apt-get upgrade
# install nodejs
$ curl -sL https://deb.nodesource.com/setup | sudo bash -
$ sudo apt-get install nodejs
$ cd /home/pi/Desktop/alexa-avs-raspberry-pi-master/samples/companionService
$ npm install
```

### JDKとMavenのインストール
公式DocはMavenの環境変数は `/etc/profile.d/maven.sh` に追加する方法ですが、うまくいかなかったので手っ取り早く `bashrc` に追加して進めました。

```sh
# java
$ cd /home/pi/Desktop/alexa-avs-raspberry-pi-master/samples/javaclient
$ ./install-java8.sh
# maven
$ wget http://apache.osuosl.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
$ sudo tar xvf apache-maven-3.3.9-bin.tar.gz  -C /opt
# add maven_vars
$ echo "export M2_HOME=/opt/apache-maven-3.3.9" >> ~/.bashrc
$ echo "export PATH=$PATH:$M2_HOME/bin" >> ~/.bashrc
$ source ~/.bashrc
```

### 証明書生成スクリプトを実行
プロダクトID、シリアル番号、パスワードの3つを入力します。今回はパスワードは空のままで進めます。

```sh
$ /home/pi/Desktop/alexa-avs-raspberry-pi-master/samples/javaclient/generate.sh
> product ID: my_device
> Serial Number: 123456
> Password: [blank]
```

### クライアントIDとClientSecretを発行
ここは [公式Doc](https://github.com/amzn/alexa-avs-raspberry-pi#user-content-6---getting-started-with-alexa-voice-service) の画像のとおり進めればよいです。

### サーバとクライアントを起動
下記のとおりサーバを起動します。 `config.js` には先ほど発行したクライアントIDとClientSecretを入力しておきます。

```sh
# setup clientId and ClientSecret
$ vi /home/pi/Desktop/alexa-avs-raspberry-pi-master/samples/companionService/config.js
$ cd /home/pi/Desktop/alexa-avs-raspberry-pi-master/samples/companionService
$ npm start
```

続いてクライアントも起動します。起動するとGUIも一緒に立ち上がります。 `DISPLAY=:1.0` はVNC経由の場合の指定です。外部ディスプレイを使う場合は `DISPLAY=:0.0` です。

```sh
$ cd /home/pi/Desktop/alexa-avs-raspberry-pi-master/samples/javaclient
$ mvn install
$ export DISPLAY=:1.0
$ mvn exec:exec
```
GUIに出てくるURLにアクセスしてデバイスの登録になります。ここも [公式Doc](https://github.com/amzn/alexa-avs-raspberry-pi#user-content-10---obtain-authorsization-from-login-with-amazon) の画像のとおりです。以上が終わると、AVSを利用できます。

## 次回予告
次回はAlexa Skillsを登録して使ってみようと思います。乞うご期待。Don't miss out!
