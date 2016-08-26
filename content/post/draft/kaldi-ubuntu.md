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
```

```sh
cd kaldi
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
cd tools
cat INSTALL
```

```sh
To install the most important prerequisites for Kaldi:
$ make -j 4

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

```sh
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

```sh
$ sudo apt-get install  automake autoconf libtool subversion
$ sudo apt-get install -y libatlas3-base
$ sudo ln -s -f bash /bin/sh
```

```sh
$ nproc
1
```

```sh
$ sudo make
```

```
Warning: IRSTLM is not installed by default anymore. If you need IRSTLM
Warning: use the script extras/install_irstlm.sh
All done OK.
```

```sh
$ cd ../src
$ cat INSTALL
```
```sh
These instructions are valid for UNIX-like systems (these steps have
been run on various Linux distributions; Darwin; Cygwin).  For native Windows
compilation, see ../windows/INSTALL.

You must first have completed the installation steps in ../tools/INSTALL
(compiling OpenFst; getting ATLAS and CLAPACK headers).

The installation instructions are:
./configure
make depend
make

Note that "make" takes a long time; you can speed it up by running make
in parallel if you have multiple CPUs, for instance 
 make depend -j 8
 make -j 8
For more information, see documentation at http://kaldi-asr.org/doc/
and click on "The build process (how Kaldi is compiled)".
```

```sh
$ ./configure
$ sudo make depend
$ sudo make
```
