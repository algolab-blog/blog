+++
author = "Shinpei Kawahito"
date = "2016-08-12T11:55:02+09:00"
draft = true
tags = []
title = "iOSで音声認識 〜Speech Frameworkを試す〜"
+++

2016/08/12現在、まだβ版という位置づけですが、Apple謹製の音声認識エンジン (Speech Framework) が公開されています。今回は、下記のサンプルコードを動作させてみます。
https://developer.apple.com/library/prerelease/content/samplecode/SpeakToMe/Introduction/Intro.html

動作を確認するにはXcode 8.0以降、iOS 10.0 以降が必要なので、環境を整えるところから始めます。

## Apple Developer Program へ登録
諸々インストールするためには、Developer登録が必須なので、以下より登録を行います。
https://developer.apple.com/programs/jp/

## Xcode 8 betaをMacにインストール
Macから下記サイトへアクセスし、Xcode 8.0 betaをダウンロード、インストールします。  
https://developer.apple.com/download/

## iOS 10 betaをiPhone にインストール
iPhoneからダウンロードサイトへアクセスし、iOS 10 betaをダウンロードします。  
https://developer.apple.com/download/
{{<img_rel "ios10_download.png">}}

ダウンロード完了後、インストールを行います。
{{<img_rel "ios10_install.png">}}

## サンプルコードをダウンロード
https://developer.apple.com/library/prerelease/content/samplecode/SpeakToMe/Introduction/Intro.html
{{<img_rel "speak_to_me.png">}}

## Signingの確認
サンプルコードを開き、  
TARGETS -> General -> Signing にDeveloper登録を行っているTeamが選択されているか確認します。  
ここが正しく設定されていないと実機でのビルドに失敗します。
{{<img_rel "signing.png">}}
