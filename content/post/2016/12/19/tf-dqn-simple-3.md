+++
draft = false
tags = [
  "reinforcement-learning",
  "dqn",
  "tensorflow"
]
series = "tf-dqn-simple"
title = "超シンプルにTensorFlowでDQN (Deep Q Network) を実装してみる 〜実装編②  学習の流れを理解する〜"
authors = "kawahito"
date = "2016-12-19T18:33:39+09:00"
+++

今回は、学習の流れについて解説します。

対象とするソースコードは下記となります。  
https://github.com/algolab-inc/tf-dqn-simple/blob/master/train.py  


## 学習の流れ
{{<gist_it "algolab-inc" "tf-dqn-simple" "train.py" "25:40">}}

学習の肝となるのは、上記のコードとなります。  
フロー図で示したものが下記となります。
登場人物として、ゲームを学習する本体 (エージェント) と、ゲーム (環境) があります。

{{<img_rel "flow.png">}}

それでは、順を追って見ていきましょう。

## ① アクションを選択
{{<gist_it "algolab-inc" "tf-dqn-simple" "train.py" "29:30">}}

エージェントは、時刻tにおけるゲームの状態 (`state_t`) を受け取って、アクションを選択します。詳細は後述しますが、一定割合 (`self.exploration`) ではランダム選択、残りの割合では学習結果から最適なものを選択、という処理をしています。

## ② アクションを実行
{{<gist_it "algolab-inc" "tf-dqn-simple" "train.py" "30:31">}}

選択されたアクションを、ゲームで実行します。

## ③  観察
{{<gist_it "algolab-inc" "tf-dqn-simple" "train.py" "33:34">}}

アクションが実行された結果を観察します。具体的には、次 (時刻t1) の状態 (`state_t_1`)、報酬 (`reward_t`)、終了フラグ (`terminal`) を受け取ります。

## ④  経験を蓄積
{{<gist_it "algolab-inc" "tf-dqn-simple" "train.py" "36:37">}}

エージェントは、学習を行うための経験を蓄積します。具体的には、ある状態 (`state_t`) に対して、あるアクション (`action_t`) を行なった結果、どのような状態になったか(`state_t_1`)、報酬はいくらか (`reward_t`)、ゲームの終了フラグ(`terminal`) を保持して、学習に活かします。

## ⑤  経験再生
{{<gist_it "algolab-inc" "tf-dqn-simple" "train.py" "39:40">}}

これまで蓄積した経験をもとに学習を行います。こちらについても詳細は後述します。

## まとめ
今回は学習の流れについて解説しました。  
次回はエージェントの中身について見ていきます。(最終回となる予定です)
