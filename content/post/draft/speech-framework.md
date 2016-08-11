+++
author = "Shinpei Kawahito"
date = "2016-08-09T11:55:02+09:00"
draft = true
tags = []
title = "iOSで音声認識 〜Speech Frameworkを試す〜"
+++

https://developer.apple.com/library/prerelease/content/samplecode/SpeakToMe/Introduction/Intro.html

動作を確認するにはXcode 8.0以降、iOS 10.0 以降が必要なので、環境を整えます。

## Apple Developer Program へ登録
開発者登録が必須なので、まだの方は以下より登録を行ってください。  
https://developer.apple.com/programs/jp/

## Xcode 8.0 をMacにインストール
Macからダウンロードサイトへアクセスします。  
https://developer.apple.com/download/

## iOS 10.0 をiPhone にインストール
iPhoneからダウンロードサイトへアクセスします。
https://developer.apple.com/download/

iOS 10 betaをダウンロードします。  
(2016/08/10 現在、beta 4 が最新だったので、beta 4 をダウンロードしました。)
{{<img_rel "ios10_download.png">}}

ダウンロード完了後、インストールを行います。
{{<img_rel "ios10_install.png">}}

## a
TARGETS -> General -> Signing から、Developer登録を行っているTeamを選択します。
