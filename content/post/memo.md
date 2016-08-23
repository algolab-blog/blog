## Selective Search
DeepLearning界隈では、物体検出

## dlibのインストール
Pythonライブラリが公開されているので、必要なパッケージとともにインストールします。  
筆者はPython環境にAnacondaを用いているので、```conda```経由でインストールを行いました。

```sh
$ sudo apt-get install -y libboost-python-dev cmake
$ conda install -c wordsforthewise dlib
```

なお、Anaconda環境の構築については下記にまとめていますので、ご参照ください。  
[【随時更新】pyenv + Anaconda (Ubuntu 16.04 LTS) で機械学習のPython開発環境をオールインワンで整える]({{<ref "post/2016/08/21/pyenv-anaconda-ubuntu.md">}})

## dlibのサンプルを動かす
```sh
$ git clone https://github.com/davisking/dlib.git
$ cd dlib
$ python python_examples/face_detector.py examples/faces/2007_007763.jpg 
Processing file: examples/faces/2007_007763.jpg
Number of faces detected: 7
Detection 0: Left: 93 Top: 194 Right: 129 Bottom: 230
Detection 1: Left: 193 Top: 90 Right: 229 Bottom: 126
Detection 2: Left: 293 Top: 86 Right: 329 Bottom: 122
Detection 3: Left: 157 Top: 114 Right: 193 Bottom: 150
Detection 4: Left: 177 Top: 214 Right: 213 Bottom: 250
Detection 5: Left: 381 Top: 89 Right: 424 Bottom: 132
Detection 6: Left: 309 Top: 233 Right: 352 Bottom: 276
Hit enter to continue
```

領域
Faster R-CNN
