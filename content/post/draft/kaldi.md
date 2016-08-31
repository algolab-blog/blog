+++
tags = [
  "speech-recognition",
  "kaldi",
  "ubuntu"
]
title = "Kaldiで音声を学習させる 〜ディープラーニングを用いた音声認識ツールキット〜"
authors = "kawahito"
date = "2016-08-26T11:54:30+09:00"
draft = true
+++

{{<img_rel "kaldi_text_and_logo.png">}}

## Kaldiとは
C++で書かれた音声認識ツールキットで、Apache Licence 2.0で公開されています。  
音響モデルにDNN (Deep Neural Network) を用いているのが特長です。

http://kaldi-asr.org/

今回はKaldiを動作させ、yesかnoの音声を判別するモデルを学習させてみます。

## 環境
Vagrant上のUbuntu 16.04 LTSを用いています。
{{<ubuntu_16>}}

## Kaldiのダウンロード
Githubよりダウンロードします。
```sh
$ git clone https://github.com/kaldi-asr/kaldi.git
```

## インストール
インストール方法は```INSTALL```ファイルに最新情報が記載されているので、それに従います。

```sh
$ cd kaldi
$ cat INSTALL
```

> This is the official Kaldi INSTALL. Look also at INSTALL.md for the git mirror installation.  
[for native Windows install, see windows/INSTALL]  

> (1)  
go to tools/  and follow INSTALL instructions there.

> (2)  
go to src/ and follow INSTALL instructions there.

``tools``および``src``フォルダの```INSTALL```を見れば良いようなので、まず``tools``から確認していきます。

## toolsのインストール
```sh
$ cd tools
$ cat INSTALL
```

> To install the most important prerequisites for Kaldi:  

> &nbsp;first do

> &nbsp;&nbsp;extras/check_dependencies.sh

> to see if there are any system-level installations or modifications you need to do.  
Check the output carefully: there are some things that will make your life a lot  
easier if you fix them at this stage.  

> Then run

> &nbsp;make

> If you have multiple CPUs and want to speed things up, you can do a parallel  
build by supplying the "-j" option to make, e.g. to use 4 CPUs:

> &nbsp;&nbsp;make -j 4

> By default, Kaldi builds against OpenFst-1.3.4. If you want to build against  
OpenFst-1.4, edit the Makefile in this folder. Note that this change requires  
a relatively new compiler with C++11 support, e.g. gcc >= 4.6, clang >= 3.0.

> In extras/, there are also various scripts to install extra bits and pieces that  
are used by individual example scripts.  If an example script needs you to run  
one of those scripts, it will tell you what to do.  

概要は以下の通りです。

* ```extras/check_dependencies.sh```で依存関係をチェック
* ```make```コマンドでインストールを行う
 - マルチコアのCPUの場合は```j```オプションをつけることでインストールが並列化できる (早くなる)

### 依存関係のチェック
スクリプトを用いて依存関係をチェックします。

```sh
$ extras/check_dependencies.sh

extras/check_dependencies.sh: automake is not installed.
extras/check_dependencies.sh: autoconf is not installed.
extras/check_dependencies.sh: neither libtoolize nor glibtoolize is installed
extras/check_dependencies.sh: subversion is not installed
extras/check_dependencies.sh: default or create an bash alias for kaldi scripts to run correctly
extras/check_dependencies.sh: we recommend that you run (our best guess):
 sudo apt-get install  automake autoconf libtool subversion
You should probably do:
 sudo apt-get install libatlas3-base
/bin/sh is linked to dash, and currently some of the scripts will not run
properly.  We recommend to run:
 sudo ln -s -f bash /bin/sh
```

サジェストされた通りに進めます。  
(環境によって出てくるメッセージが異なるのでご注意下さい)

```sh
$ sudo apt-get install automake autoconf libtool subversion
$ sudo apt-get install -y libatlas3-base
$ sudo ln -s -f bash /bin/sh
```

再度依存関係をチェックすると、OKとなりました。

```sh
$ extras/check_dependencies.sh
extras/check_dependencies.sh: all OK.
```

### インストール
まず、手元の環境のCPUコア数を調べます。

```sh
$ nproc
4
```

筆者の環境は4コアだったので、```j```オプションを用いて並列インストールを行います。

```sh
$ sudo make -j 4
```

## srcのインストール
```sh
$ cd ../src
$ cat INSTALL
```

> These instructions are valid for UNIX-like systems (these steps have  
been run on various Linux distributions; Darwin; Cygwin).  For native Windows  
compilation, see ../windows/INSTALL.

> You must first have completed the installation steps in ../tools/INSTALL  
(compiling OpenFst; getting ATLAS and CLAPACK headers).  

> The installation instructions are:  
./configure  
make depend  
make

> Note that "make" takes a long time; you can speed it up by running make  
in parallel if you have multiple CPUs, for instance  
 make depend -j 8  
 make -j 8  
For more information, see documentation at http://kaldi-asr.org/doc/  
and click on "The build process (how Kaldi is compiled)".  

以下の3つのコマンドを叩けば良いようので、一つずつ叩いていきます。

```sh
$ ./configure
$ sudo make depend -j 4
$ sudo make -j 4
```

## サンプルの動作確認
``egs``以下にサンプルが公開されています。  
ここでは、``yes``と``no``を判別する非常に小さなタスクを学習させてみます。

```sh
cd ../egs/yesno
cat README.txt
```

> The "yesno" corpus is a very small dataset of recordings of one individual  
saying yes or no multiple times per recording, in Hebrew.  It is available from  
http://www.openslr.org/1.  
It is mainly included here as an easy way to test out the Kaldi scripts.  

> The test set is perfectly recognized at the monophone stage, so the dataset is  
not exactly challenging.

> The scripts are in s5/.

ヘブライ語で``yes``と``no``を喋っているコーパスを学習データとして用いるようです。  
``s5``フォルダに動作用のスクリプトがあるので、動かしてみます。

```sh
$ cd s5
$ sh run.sh
...
%WER 0.00 [ 0 / 232, 0 ins, 0 del, 0 sub ] exp/mono0a/decode_test_yesno/wer_10
```

## サンプルの動作詳細
``run.sh``が何をやっているのかをコードとともに見ていきます。

1. データのダウンロード
1. データの準備

### データのダウンロード
```sh
if [ ! -d waves_yesno ]; then
  wget http://www.openslr.org/resources/1/waves_yesno.tar.gz || exit 1;
  tar -xvzf waves_yesno.tar.gz || exit 1;
fi
```

下記URLからデータをダウンロード、解凍しています。  
http://www.openslr.org/resources/1/waves_yesno.tar.gz

実行後、``waves_yesno``以下に8khz にサンプリングされた60個の音声ファイルができます。  
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

### データの準備
#### 訓練データおよびテストデータの作成
```sh
local/prepare_data.sh waves_yesno
```

先ほどの60個のファイルの半分を訓練データ、残り半分をテストデータに分割し、諸々加工しています。
``data/train_yesno``および``data/test_yesno``以下にデータが作成されます。


#### 辞書の作成
```sh
local/prepare_dict.sh
```

``data/local/dict``以下に辞書ファイルを作ります。
``YES``, ``NO``, ``SIL(無音)``の3種類の言葉を定義しています。

#### 言語の準備
```sh
utils/prepare_lang.sh --position-dependent-phones false data/local/dict "<SIL>" data/local/lang data/lang
```

#### 言語モデルの作成
```sh
local/prepare_lm.sh
```

### 特徴抽出
```sh
for x in train_yesno test_yesno; do 
 steps/make_mfcc.sh --nj 1 data/$x exp/make_mfcc/$x mfcc
 steps/compute_cmvn_stats.sh data/$x exp/make_mfcc/$x mfcc
 utils/fix_data_dir.sh data/$x
done
```

音声から特徴量を抽出します。特徴量としてはMFCC (メル周波数ケプストラム係数) を用いています。

### 訓練

### 
