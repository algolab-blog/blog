+++
tags = [
  "speech-recognition",
  "kaldi"
]
title = "kaldi ubuntu"
authors = "kawahito"
date = "2016-08-26T11:54:30+09:00"
draft = true
+++

```sh
git clone https://github.com/kaldi-asr/kaldi.git
cd kaldi/
```

```sh
cat INSTALL
```

```sh
This is the official Kaldi INSTALL. Look also at INSTALL.md for the git mirror installation.
[for native Windows install, see windows/INSTALL]

(1)
go to tools/  and follow INSTALL instructions there.

(2)
go to src/ and follow INSTALL instructions there.
```

```sh
cd tools/
cat INSTALL
```

```sh
To install the most important prerequisites for Kaldi:

 first do

  extras/check_dependencies.sh

to see if there are any system-level installations or modifications you need to do.
Check the output carefully: there are some things that will make your life a lot
easier if you fix them at this stage.

Then run

  make

If you have multiple CPUs and want to speed things up, you can do a parallel
build by supplying the "-j" option to make, e.g. to use 4 CPUs:

  make -j 4

By default, Kaldi builds against OpenFst-1.3.4. If you want to build against
OpenFst-1.4, edit the Makefile in this folder. Note that this change requires
a relatively new compiler with C++11 support, e.g. gcc >= 4.6, clang >= 3.0.

In extras/, there are also various scripts to install extra bits and pieces that
are used by individual example scripts.  If an example script needs you to run
one of those scripts, it will tell you what to do.
```

```sh
$ extras/check_dependencies.sh
```

```
extras/check_dependencies.sh  
extras/check_dependencies.sh: automake is not installed.
extras/check_dependencies.sh: autoconf is not installed.
extras/check_dependencies.sh: neither libtoolize nor glibtoolize is installed
extras/check_dependencies.sh: subversion is not installed
extras/check_dependencies.sh: python 2.7 is not the default python. You should either make it
extras/check_dependencies.sh: default or create an bash alias for kaldi scripts to run correctly
extras/check_dependencies.sh: we recommend that you run (our best guess):
 sudo apt-get install  automake autoconf libtool subversion
You should probably do: 
 sudo apt-get install libatlas3-base
/bin/sh is linked to dash, and currently some of the scripts will not run
properly.  We recommend to run:
 sudo ln -s -f bash /bin/sh
```

```
$ sudo apt-get install libatlas3-base
$ sudo ln -s -f bash /bin/sh
