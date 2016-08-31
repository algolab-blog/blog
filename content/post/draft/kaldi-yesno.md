+++
date = "2016-08-31T14:35:21+09:00"
draft = true
tags = [
  "speech-recognition",
  "kaldi",
]
title = "Kaldiでyes/noを判別するソースコードを読む"
authors = "kawahito"
+++

こちらの記事の続きです。  
[Kaldiで音声を学習させる 〜ディープラーニングを用いた音声認識ツールキット〜]({{<ref "post/2016/08/31/kaldi.md">}})

今回は、``egs/yesno/s5/run.sh``が何をやっているのか具体的に見ていきます。  
以下、カレントディレクトリが``egs/yesno/s5``であることを前提としています。

## 1. データのダウンロード
```sh
if [ ! -d waves_yesno ]; then
  wget http://www.openslr.org/resources/1/waves_yesno.tar.gz || exit 1;
  tar -xvzf waves_yesno.tar.gz || exit 1;
fi
```

まず、下記URLからデータをダウンロード、解凍しています。  
http://www.openslr.org/resources/1/waves_yesno.tar.gz

実行すると、``waves_yesno``以下に8khz にサンプリングされた60個の音声ファイルができます。  
それぞれのファイルには``yes``か``no``のどちらかの音声が8個収録されており、内容はファイル名で示されています。  

``yes``が``1``、``no``が``0``で表現されており、  
例えば下記のファイルは``no, no, no, no, yes, yes, yes, yes``という音声が収録されていることを示します。  

```sh
0_0_0_0_1_1_1_1.wav
```

音声ファイルを再生するには下記のコマンドを叩きます。

```sh
$ aplay waves_yesno/0_0_0_0_1_1_1_1.wav
```

ヘブライ語で収録されているので、``yes``は``ken``、``no``は``lo``と聞こえると思います。

## 2. データの準備
### 2-1. 訓練データおよびテストデータの作成
```sh
local/prepare_data.sh waves_yesno
```

先ほどの60個のファイルの半分を訓練データ、残り半分をテストデータに分割し、諸々加工しています。
最終的に、``data/train_yesno``および``data/test_yesno``以下にデータが作成されます。

```sh
$ ls -1 data/train_yesno
spk2utt
text
utt2spk
wav.scp
```

### 辞書の作成
```sh
local/prepare_dict.sh
```

``data/local/dict``以下に辞書ファイルを作ります。
``YES``, ``NO``, ``SIL(無音)``の3つを定義しています。

### 言語の準備
```sh
utils/prepare_lang.sh --position-dependent-phones false data/local/dict "<SIL>" data/local/lang data/lang
```

### 言語モデルの作成
```sh
local/prepare_lm.sh
```

## 特徴抽出
```sh
for x in train_yesno test_yesno; do 
 steps/make_mfcc.sh --nj 1 data/$x exp/make_mfcc/$x mfcc
 steps/compute_cmvn_stats.sh data/$x exp/make_mfcc/$x mfcc
 utils/fix_data_dir.sh data/$x
done
```

音声から特徴量を抽出します。特徴量としてはMFCC (メル周波数ケプストラム係数) を用いています。

## 訓練

### 

