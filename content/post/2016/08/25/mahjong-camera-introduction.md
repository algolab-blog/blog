+++
authors = "kawahito"
date = "2016-08-25T16:28:18+09:00"
draft = false
tags = ["mahjong-camera", "image-recognition"]
title = "麻雀カメラプロジェクト再始動？ 〜【導入編】テンプレートマッチングによる麻雀牌判定〜"
+++

2014年の終わり頃に「麻雀カメラ」というiPhoneアプリを作っていました。  
カメラをかざすだけで麻雀の得点計算を行ってくれるアプリです。

{{<youtube "livDDcygEDU">}}

動画を見ていただければ一目瞭然ですが、さすがに実用では使えない、ということでお蔵入りしました...。  
(時間がかかるだけでなく、精度もあまり良くありませんでした。)  

あれから一年半、技術の進歩は目覚ましく、いまならば良いものが作れるのでは？と思い立ち、再挑戦してみることにしました。  

今回は、導入編として、当時用いていた手法 (テンプレートマッチング) について説明します。

## 画像判定プロセス
画像に何が写っているか判定するためには、大きく「検出 (Detection)」と「認識 (Recognition)」というプロセスに分かれます。

### 検出
物体が画像内のどこにあるかを判定するプロセス。  
下記の画像でいうと、赤枠をつけていくイメージです。

{{<img_rel "detection_1.png">}}

### 認識
検出された領域に写っている物体が何であるかを判定するプロセス。  
具体的には、下記の物体が「五萬」である、と識別することを言います。

{{<img_rel "5m.png">}}

## 検出の難しさ
麻雀牌判定においては、特に「検出」のプロセスが困難です。  
横並びの複数牌に対し、どこが牌の境界かを判断することが非常に難しいのです。  
例えば、下記の画像を考えてみましょう。

{{<img_rel "detection_2.png">}}

人間の目には、3つの牌の境界を判断することはできますが、  
機械では、下記の赤枠の部分を1つの牌として検出してしまう、ということが起こり得てしまいます。

{{<img_rel "detection_3.png">}}

牌の境界には溝らしきものが存在するので、画像処理で溝を判定し境界とみなす、というような実装も考えられますが、光の具合や撮影角度などによって溝が見えなくなってしまうこともあるため、このような特定のルールを設ける方法では一筋縄ではいきません。  

## 当時用いていたアルゴリズム
当時はどのように判定していたかというと、前処理を加えた画像に対し、テンプレートマッチングという手法を用いていました。(古くからある手法です)

## 前処理
前処理として、画像全体から牌が写っている全体領域を切り出します。  
牌の全体領域と背景には明らかに差が見て取れるので、これは比較的容易に行うことができます。  

{{<img_rel "detection_4.png">}}

具体的には、二値化画像に対し輪郭抽出を行い、頂点数や面積が一定以上のものの外接矩形を牌の全体領域としてみなす、という処理をしています。

処理後の画像はこのような形となります。

{{<img_rel "template_matching_1.png">}}

## テンプレートマッチング
前処理を行った画像に対し、テンプレートマッチングを用いて牌を判定していきます。

テンプレートマッチングとは、テンプレート画像を少しずつ端から端までずらしていって、その類似度を計算していく、という手法です。

例えばテンプレート画像に「五萬」を用いるとしましょう。  
下記のように、少しずつずらして類似度を計算していき、その値を保持しておきます。

{{<img_rel "template_matching_2.png">}}

そして、一番類似度が高い領域を個別牌領域としてみなします。

{{<img_rel "template_matching_3.png">}}

実際には、テンプレート画像には、麻雀牌の種類 (34) x 上下左右の方向 (4) の合計136個を用い、一番類似度の高かったものを採用しています。

そして、確定した領域を除いた残りの領域に対して更にテンプレートマッチングを繰り返していくことで牌の判定を行っていました。

## 問題点
テンプレートマッチングは、いわば総当たり作戦で「検出」と「認識」を一度に行ってしまおうというものです。  
ご想像の通り、非常に効率が悪く、判定に時間がかかってしまいます。

またテンプレート画像は上下左右の4方向しか用意していないため、例えば下記の中だと「六萬」の判定がうまくいきません。
{{<img_rel "template_matching_4.png">}}

単純に考えると、テンプレートを増やせば良さそうですが、速度とのトレードオフなので現実的ではありません。

## 次回予告
このように、テンプレートマッチングを用いる手法では、限られた条件下 (横並びに綺麗に牌が並んでいる) ではそれなりに精度は出るものの、条件から外れると精度が落ち、また判定に時間もかかってしまいました。

次回以降、これらの問題点を解決すべく、いろいろな手法を試していきたいと思います。