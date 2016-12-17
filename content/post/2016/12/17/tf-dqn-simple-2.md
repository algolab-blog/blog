+++
title = "超シンプルにTensorFlowでDQN (Deep Q Network) を実装してみる 〜実装編①  ゲームを作る〜"
authors = "kawahito"
date = "2016-12-17T17:02:04+09:00"
draft = false
tags = [
  "reinforcement-learning",
  "dqn",
  "tensorflow"
]
series = "tf-dqn-simple"
+++

今回から、実装編についてお届けします。  
本記事では、学習させるゲームの部分について、重要な箇所を抜粋して解説します。

対象とするソースコードは下記となります。  
https://github.com/algolab-inc/tf-dqn-simple/blob/master/catch_ball.py

それでは早速いってみましょう。

## ゲームの概要
{{<img_rel "demo-catch_ball.gif">}}

おさらいになりますが、ゲームの概要としては、上図のように上から落ちてくるボールをキャッチする、というものになります。キャッチできれば`+1点`、キャッチできなければ`-1点`というルールで高得点を目指します。

## データの持ち方
ゲーム盤は下図のように 8 x 8 の2次元配列で表現しており、「ボール」および「プレイヤー」を`1`で、背景を`0`の値として格納しています。
{{<img_rel "catch_ball.png">}}

上記の状態の場合、各種インスタンス変数の値は下記となります。

変数名 | 値 | 説明
:------|:---|:----
screen_n_rows | 8 | ゲーム盤の方向の長さ
screen_n_cols | 8 | ゲーム盤の横方向の長さ
ball_row | 0 | ボールの縦方向の位置
ball_col | 6 | ボールの横方向の位置
player_row | 4 | プレイヤーの左端の横方向の位置
player_length | 3 | プレイヤーの横方向の長さ

## ゲームの更新処理
続いて、ゲームの更新処理を行う`update`メソッドを見ていきましょう。

### 引数
{{<gist_it "algolab-inc" "tf-dqn-simple" "catch_ball.py?slice=17:24">}}
`update`メソッドは引数として`action`を受け取ります。`action`はプレイヤーの行動を表すもので、`0,1,2`のいずれかの数値で表現しており、それぞれ「何もしない」「左に動く」「右に動く」ことを示します。

### プレイヤーの位置の更新
{{<gist_it "algolab-inc" "tf-dqn-simple" "catch_ball.py?slice=25:35">}}

プレイヤーの位置を更新しています。ゲーム盤からはみ出さないように制御しているのがポイントです。

### ボールの位置の更新
{{<gist_it "algolab-inc" "tf-dqn-simple" "catch_ball.py?slice=36:37">}}

こちらは単純に、下に1つずらすという処理をしています。

### 得点判定
{{<gist_it "algolab-inc" "tf-dqn-simple" "catch_ball.py?slice=41:49">}}

ボールがゲーム盤の下端に来た時に、ゲーム終了フラグをセット (`self.terminal = True`) した上で、得点判定処理を行います。プレイヤーの範囲内にボールがあればキャッチできたとみなし `+1点` (`self.reward = 1`)、そうでなければキャッチできなかったとして、`-1点` (`self.reward = -1`)、としています。

## 次回予告
次回は、ゲームを学習する部分（エージェント）について解説します。
