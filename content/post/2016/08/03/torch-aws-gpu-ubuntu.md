+++
author = "Shinpei Kawahito"
date = "2016-08-03T17:12:34+09:00"
draft = false
title = "TorchをAWSのGPUインスタンス (Ubuntu 14.04) で動かす"
+++

TorchをAWSのGPUインスタンス (Ubuntu 14.04) で動かす手順をまとめます。  
環境は以下の通りです。

* Ubuntu Server 14.04 LTS
* CUDA7.5
* CuDNN v5
* Torch7

## インスタンスを起動
{{<img_rel "ubuntu.png">}}

Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-2d39803a をベースに構築します。  
インスタンスタイプはg2.2xlargeを用いました。  
ストレージ容量はデフォルトの8GBでは不足するので、16GBとします。  

{{<img_rel "storage.png">}}

## パッケージ更新
インスタンスが起動したら、SSHでログインのうえ、まずパッケージを更新します。
```sh
sudo apt-get update
sudo apt-get upgrade -y
```

## CUDAインストール
CUDAのインストールはハマりどころが多いですが、先人の知恵にならって進めます。  
https://gist.github.com/erikbern/78ba519b97b440e10640

既存のドライバ (Noveau) を無効にします。
```sh
echo -e "blacklist nouveau\nblacklist lbm-nouveau\noptions nouveau modeset=0\nalias nouveau off\nalias lbm-nouveau off\n" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u
sudo reboot
```

必要なカーネルモジュールをインストールします。
```sh
sudo apt-get install -y linux-image-extra-virtual
sudo reboot
sudo apt-get install -y linux-source linux-headers-`uname -r`
```

CUDA7.5をインストールします。
```sh
wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run
chmod +x cuda_7.5.18_linux.run
./cuda_7.5.18_linux.run -extract=`pwd`/nvidia_installers
cd nvidia_installers
sudo ./NVIDIA-Linux-x86_64-352.39.run
sudo modprobe nvidia
sudo ./cuda-linux64-rel-7.5.18-19867135.run
```

途中でシンボリックリンクを作成するか聞かれますが、yesを選択します。
```sh
Would you like to create a symbolic link /usr/local/cuda pointing to /usr/local/cuda-7.5? ((y)es/(n)o/(a)bort) [ default is yes ]: y
```

CUDAのパスを環境変数に追加します。
```sh
echo -e "export PATH=/usr/local/cuda/bin:\$PATH\nexport LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH" | tee -a ~/.bashrc
source ~/.bashrc
```

## CUDNNインストール
まず、下記のサイトからアカウントを登録します。  
https://developer.nvidia.com/cudnn  

アカウント登録後、ダウンロードページから、cuDNN v5 Library for Linuxをダウンロードします。
{{<img_rel "cudnn.png">}}

ダウンロードしたファイルをサーバへ転送後、サーバ上で展開します。
```sh
tar -xzf cudnn-7.5-linux-x64-v5.0-ga.tgz
sudo cp cuda/lib64/libcudnn* /usr/local/cuda-7.5/lib64
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
```

## Torchインストール
公式に従って、インストールします。  
http://torch.ch/docs/getting-started.html  

```sh
sudo apt-get install -y git
git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch; bash install-deps;
./install.sh
```

環境変数を.bashrcに書き込むか聞かれますが、yesを選択します。
```sh
Do you want to automatically prepend the Torch install location
to PATH and LD_LIBRARY_PATH in your /home/ubuntu/.bashrc? (yes/no)
[yes] >>> 
yes
```

環境変数を反映します。
```sh
source ~/.bashrc
```

最後に、CUDAおよびcuDNNを使うためのLuaライブラリをインストールします。
```sh
luarocks install cutorch
luarocks install cunn
luarocks install cunnx
luarocks install https://raw.githubusercontent.com/soumith/cudnn.torch/master/cudnn-scm-1.rockspec
```

以上で環境構築は完了です。
