+++
draft = true
tags = [
  "speech-recognition",
  "jasper"
]
title = "JasperをRaspberry Piで動かす"
authors = "kawahito"
date = "2016-08-26T21:04:48+09:00"

+++

{{<youtube "UzaqNF6NlBA">}}

## Jasper Projectとは
音声コントロールのアプリを簡単に作れるオープンソースプロジェクトです。  
バックエンドには [CMU Sphix](http://cmusphinx.sourceforge.net/) の PocketSphinx を STT (Speech-to-Text) エンジンとして用いています。  
また、サードパーティモジュールも多数公開されており、GoogleCalendar等と容易に連携させることが可能です。  
http://jasperproject.github.io/documentation/modules/

## 環境
以下を動作環境として用いました。

* Raspberry Pi 3 Model B
* Raspbian Jessie (2016-05-27)

セットアップについては、基本的には下記のドキュメント (Method 3) に従います。
http://jasperproject.github.io/documentation/installation/

なお、OSのインストールに関しては、[こちら]({{<ref "post/2016/08/11/raspberry-pi-alexa.md#raspberry-pi-を起動する">}}) をご参照ください。

## パッケージのインストール
まず、必要なパッケージをインストールします。

```sh
$ sudo apt-get update
$ sudo apt-get -y install vim git-core python-dev python-pip bison libasound2-dev libportaudio-dev python-pyaudio
```

## ALSAの設定
手元の環境では``/etc/modprobe.d/alsa-base.conf``が存在しなかったので、下記の記事を参考に進めます。  
[Raspbianで/etc/modprobe.d/alsa-base.confがないとき](http://qiita.com/fumisoro/items/a110ca2c0899fa63516a)

USBマイクを接続のうえ、サウンドデバイスの一覧を確認します。

```sh
$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 1: Device [USB PnP Audio Device], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

USBマイクのカード番号が1、デバイス番号が0なので、以下のように設定します。

```sh
$ echo "export ALSADEV='plughw:1,0'" >> ~/.bashrc
$ source ~/.bashrc
```

## 環境変数の設定

## Jasperのインストール
```sh
$ git clone https://github.com/jasperproject/jasper-client.git jasper
```
