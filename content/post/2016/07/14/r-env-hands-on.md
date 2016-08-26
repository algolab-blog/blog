+++
authors = "kawahito"
date = "2016-07-14T17:40:56+09:00"
draft = false
tags= ["robot", "study-session", "r-env", "robohon", "sota"]
title = "R-env:連舞® ハンズオンで RoBoHoN（ロボホン）・ Sota（ソータ）と戯れてきた"
+++

[[R-env:連舞® Innovation Hub] R-env:連舞®×RoBoHoNでロボットサービス開発体験ハンズオン](https://r-env.doorkeeper.jp/events/48273) に参加してきましたので、その模様をレポートします。

## R-env:連舞® とは
{{<img_rel "r-env.jpg">}}

NTTが開発を行っている、様々なロボットやデバイスと連携し、 ビジュアルプログラミング環境を用いて誰でも簡単に開発を行うことのできるプラットフォームです。

## RoBoHoN とは
{{<img_rel "robohon.jpg">}}

2016/06/29にSDKが一般公開されたのが記憶に新しいですが、SHARPが開発しているロボット電話です。  
Androidをベースとしており、標準機能の他に、HVML (Hyper Voice Markup Language) という独自の言語を用いてシナリオを作成することができるようです。  
SDKは [公式ページ](https://robohon.com/) 内のマイページよりダウンロード可能です。

## R-env と RoBoHoN の連携
{{<img_rel "r-env-robohon.jpg">}}

R-envとRoBoHoNなどの機器の間でWebSocketによる通信を行うことでインタラクションを実現しています。  
上記の図は、R-envからRoBoHonに処理を依頼する例ですが、RoBoHoN側からイベント (持ち上げられた、など) をR-envへ通知することができます。  
また、R-envには幾つもの機器を登録することができるので、例えばRoBoHoNに「エアコンつけて！」と頼むとエアコンが起動する、といったことも実現することが可能です。

## ハンズオン
今回のハンズオンでは、R-envおよびRoBoHoNの紹介の後、30分程度の自由な開発時間がありました。  
Sotaも動かしても良い、とのことだったので、RoBoHonとSotaに簡単な会話をさせてみることにしました。

## シナリオを作成する
{{<img_rel "screen_1.png">}}

GUIでフローを定義していく形となります。  
ボックスにイベントの定義、矢印にイベント遷移条件の定義を行います。

{{<img_rel "screen_2.png">}}

イベントの詳細を定義する画面です。  
ここでは、RoBoHonのプロジェクタを起動するイベントを定義しています。

## 動いた！
{{< youtube A-ArkARJUpQ >}}

> **RoBoHoN:** はじめまして、ロボホンです。  
**Sota:** はじめまして、ソータです。ロボホン、プロジェクタ写して！  
**RoBoHoN:** （プロジェクタを写す）  
**Sota:** ありがとう！僕からは音楽を流すね！（音楽を流す）

最終的に上記のようなシナリオが完成しました！リアルにモノが動くので、感動もひとしおです！！

## おわりに
手軽にロボットプログラミングが体験でき、非常に貴重な経験となりました。  
ハンズオンは定期的に開催しているようなので、みなさんも体験してみてはいかがでしょうか？  
[R-env:連舞® Innovation Hub](https://r-env.doorkeeper.jp/)
