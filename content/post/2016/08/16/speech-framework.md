+++
author = "Shinpei Kawahito"
date = "2016-08-16T19:34:57+09:00"
draft = false
tags = ["音声認識"]
title = "iOSで音声認識 〜Speech Frameworkを試す〜"
+++

2016/08/16現在、まだβ版という位置づけですが、Apple謹製の音声認識エンジン (Speech Framework) が公開されています。今回は、下記のサンプルコードを動作させてみます。
https://developer.apple.com/library/prerelease/content/samplecode/SpeakToMe/Introduction/Intro.html

動作を確認するにはXcode 8.0以降、iOS 10.0 以降が必要なので、環境を整えるところから始めます。

## Apple Developer Program へ登録
諸々インストールするためには、Developer登録が必須なので、以下より登録を行います。
https://developer.apple.com/programs/jp/

## Xcode 8 betaをMacにインストール
Macから下記ページへアクセスし、Xcode 8 betaをダウンロード、インストールします。  
https://developer.apple.com/download/

## iOS 10 betaをiPhone にインストール
iPhoneか下記ページへアクセスし、iOS 10 betaをダウンロード、インストールします。  
https://developer.apple.com/download/

## サンプルコードをダウンロード
下記ページより、サンプルコードをダウンロードします。
https://developer.apple.com/library/prerelease/content/samplecode/SpeakToMe/Introduction/Intro.html

{{<img_rel "speak_to_me.png">}}

## 署名の確認
サンプルコードを開き、```TARGETS -> General -> Signing```にDeveloper登録を行っているTeamが選択されているか確認します。
(ここが正しく設定されていないと実機でのビルドに失敗します)

## 日本語対応
``ViewController.swift``の15行目、言語指定のコードを``en-US``から``ja-JP``に書き換えます。

```swift
private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
```
## 認識精度を確認
実機で動作させ、認識精度を確認してみます。まず、「吾輩は猫である」を認識させてみます。

> 吾輩は猫である。名前はまだ無い。どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。

認識結果がこちら。

> 吾輩は猫である。名前はまだない。どこで生まれたかとんと見当がつかん。何でも薄暗いじめじめした所でニャンニャン泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。

ほぼ正解と言っていい認識精度です。ここまで精度が高いとは正直驚きです。

## 次回予告
次回はサンプルコードの中身を追ってみようと思います。
