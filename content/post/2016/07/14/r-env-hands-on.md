+++
author = "Shinpei Kawahito"
date = "2016-07-14T17:40:56+09:00"
draft = false
post = true
tags = ["R-env", "RoBoHon", "Sota"]
title = "R-env:連舞® ハンズオンで RoBoHoN（ロボホン）・ Sota（ソータ）と戯れてきた"
+++

[[R-env:連舞® Innovation Hub] R-env:連舞®×RoBoHoNでロボットサービス開発体験ハンズオン](https://r-env.doorkeeper.jp/events/48273) に参加してきましたので、その模様をレポートします。

## R-env:連舞® とは
{{< figure src="/images/2016/07/14/r-env-hands-on/r-env.jpg" >}}

様々なロボットやデバイスと連携し、 ビジュアルプログラミング環境を用いて誰でも簡単に開発を行うことのできるプラットフォームです。NTT が研究・開発を行っています。  

## RoBoHoN とは
{{< figure src="/images/2016/07/14/r-env-hands-on/robohon.jpg" >}}

2016/06/29 に SDK が一般公開されたのが記憶に新しいですが、SHARP が開発しているロボット電話です。  
Android をベースとしており、標準機能の他に、HVML (Hyper Voice Markup Language) という独自の言語を用いてシナリオを作成することができるようです。  
SDK は [公式ページ](https://robohon.com/) 内のマイページよりダウンロード可能です。


## R-env と RoBoHoN の連携
{{< figure src="/images/2016/07/14/r-env-hands-on/r-env-robohon.jpg" >}}

R-env と RoBoHoN などの機器の間で WebSocket による通信を行うことでインタラクションを実現しています。  
上記の図は、 R-env から RoBoHon に処理を依頼する例ですが、RoBoHoN 側からイベント（持ち上げられた、など）を R-env へ通知することができます。  
そして、R-env には幾つもの機器を登録することができるので、例えば RoBoHoN に「エアコンつけて！」と頼むとエアコンが起動する、といったことも実現することが可能です。

## ハンズオン
今回のハンズオンでは、R-env および RoBoHoN の紹介の後、30 分程度の自由な開発時間がありました。  
Sota も動かしても良い、とのことだったので、RoBoHon と Sota に簡単な会話をさせてみることにしました。

## シナリオを作成する
{{< figure src="/images/2016/07/14/r-env-hands-on/screen_1.png" >}}

GUI でフローを定義していく形となります。  
ボックスにイベントの定義、矢印にイベント遷移条件の定義を行います。

{{< figure src="/images/2016/07/14/r-env-hands-on/screen_2.png" >}}

イベントの詳細を定義する画面です。  
ここでは、 RoBoHon のプロジェクタを起動するイベントを定義しています。

## 完成！
{{< youtube A-ArkARJUpQ >}}

> **RoBoHoN:** はじめまして、ロボホンです。  
**Sota:** はじめまして、ソータです。ロボホン、プロジェクタ写して！  
**RoBoHoN:** （プロジェクタを写す）  
**Sota:** ありがとう！僕からは音楽を流すね！（音楽を流す）

最終的に上記のようなシナリオが完成しました！  
リアルにモノが動くので、感動もひとしおです！！

ハンズオンは定期的に開催しているようなので、みなさんも体験してみてはいかがでしょうか？  
[R-env:連舞® Innovation Hub](https://r-env.doorkeeper.jp/)
