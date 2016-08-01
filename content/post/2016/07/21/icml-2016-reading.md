+++
author = "Shinpei Kawahito"
date = "2016-07-22T10:14:41+09:00"
draft = false
tags = ["ICML"]
title = "ICML2016読み会 まとめ"
+++

[ICML2016読み会](http://connpass.com/event/34960/) の内容をまとめました。  
ニコ生配信URL：http://live.nicovideo.jp/watch/lv268597918

## ICML概要
林浩平さん ({{<twitter hayasick >}}) / 産業技術総合研究所

{{<slideshare 2OrjGekQEu2Bgr>}}
<br />

* ICMLはNIPSに次ぐ機械学習の国際会議
* ディープラーニングと、それに伴う最適化がトレンド

## Dropout distillation
佐野正太郎さん ({{<twitter g_votte>}}) / リクルートコミュニケーションズ

{{<slideshare GSKKG9nwXe83zR>}}

論文: http://jmlr.org/proceedings/papers/v48/bulo16.html

> Dropout is a popular stochastic regularization technique for deep neural networks that works by randomly dropping (i.e. zeroing) units from the network during training. This randomization process allows to implicitly train an ensemble of exponentially many networks sharing the same parametrization, which should be averaged at test time to deliver the final prediction. A typical workaround for this intractable averaging operation consists in scaling the layers undergoing dropout randomization. This simple rule called ’standard dropout’ is efficient, but might degrade the accuracy of the prediction. In this work we introduce a novel approach, coined ’dropout distillation’, that allows us to train a predictor in a way to better approximate the intractable, but preferable, averaging process, while keeping under control its computational efficiency. We are thus able to construct models that are as efficient as standard dropout, or even more efficient, while being more accurate. Experiments on standard benchmark datasets demonstrate the validity of our method, yielding consistent improvements over conventional dropout.

* Dropoutを学習に用いた場合、その予測において、時間と精度を両立することが難しかった
* Distillation (蒸留法) を応用することで、短時間で精度よく予測を行うモデルを構築した

{{<tweet 756002188770410496>}}
{{<tweet 756002470573121536>}}

## Learning Convolutional Neural Networks for Graphs
秋葉拓哉さん ({{<twitter iwiwi>}}) / Preferred Networks

{{<slideshare 3htE46MNnSfNQy>}}

論文: http://jmlr.org/proceedings/papers/v48/niepert16.html

> Numerous important problems can be framed as learning from graph data. We propose a framework for learning convolutional neural networks for arbitrary graphs. These graphs may be undirected, directed, and with both discrete and continuous node and edge attributes. Analogous to image-based convolutional networks that operate on locally connected regions of the input, we present a general approach to extracting locally connected regions from graphs. Using established benchmark data sets, we demonstrate that the learned feature representations are competitive with state of the art graph kernels and that their computation is highly efficient.

* グラフ構造 (化学化合物など) をCNNで学習させたいが、そのまま突っ込むことは難しい
* WL カーネルを応用したアルゴリズムを用いて、グラフ構造をテンソルに変換した
{{<tweet 756011698117419008>}}

## Estimating Structured Vector Autoregressive Models
谷本啓さん ({{<twitter akira_dev>}}) / NEC

{{<slideshare uzp8O2l8b8LyZK>}}

論文: http://jmlr.org/proceedings/papers/v48/melnyk16.html

> Numerous important problems can be framed as learning from graph data. We propose a framework for learning convolutional neural networks for arbitrary graphs. These graphs may be undirected, directed, and with both discrete and continuous node and edge attributes. Analogous to image-based convolutional networks that operate on locally connected regions of the input, we present a general approach to extracting locally connected regions from graphs. Using established benchmark data sets, we demonstrate that the learned feature representations are competitive with state of the art graph kernels and that their computation is highly efficient.

* 一般のノルムでの正規化を用いた VARモデルの推定の非漸近的な解析を行った
* 収束ルートはi.i.dと同じだった

## Meta-Learning with Memory-Augmented Neural Networks
渡辺有祐さん / SONY

{{<slideshare tj8ML4cdtq2M7s>}}

論文: http://jmlr.org/proceedings/papers/v48/santoro16.html

> Modeling the distribution of natural images is a landmark problem in unsupervised learning. This task requires an image model that is at once expressive, tractable and scalable. We present a deep neural network that sequentially predicts the pixels in an image along the two spatial dimensions. Our method models the discrete probability of the raw pixel values and encodes the complete set of dependencies in the image. Architectural novelties include fast two-dimensional recurrent layers and an effective use of residual connections in deep recurrent networks. We achieve log-likelihood scores on natural images that are considerably better than the previous state of the art. Our main results also provide benchmarks on the diverse ImageNet dataset. Samples generated from the model appear crisp, varied and globally coherent.

* Neural Turing Machine を One-Shot Learning に応用し、高い精度を得た

{{<tweet 756028694196396032>}}
{{<tweet 756031082303152130>}}

## Pixel Recurrent Neural Networks
得居誠也さん ({{<twitter beam2d >}}) / Preferred Networks

{{<slideshare  3bJ5TFJmX7Bk1K>}}

論文: http://jmlr.org/proceedings/papers/v48/oord16.html

> Modeling the distribution of natural images is a landmark problem in unsupervised learning. This task requires an image model that is at once expressive, tractable and scalable. We present a deep neural network that sequentially predicts the pixels in an image along the two spatial dimensions. Our method models the discrete probability of the raw pixel values and encodes the complete set of dependencies in the image. Architectural novelties include fast two-dimensional recurrent layers and an effective use of residual connections in deep recurrent networks. We achieve log-likelihood scores on natural images that are considerably better than the previous state of the art. Our main results also provide benchmarks on the diverse ImageNet dataset. Samples generated from the model appear crisp, varied and globally coherent.

* 画像生成において、VAEやGANとは異なる自己回帰 (RNNに似たもの) のアプローチを用いたところ、綺麗な画像を生成できた
* 並列化により、高速な勾配計算も両立した

{{<tweet 756037448879136768>}}
{{<tweet 756038954550304768>}}
{{<tweet 756042609060040705>}}

## Dynamic Memory Networks for Visual and Textual Question Answering
花木健太郎さん {{{<twitter csstudyabroad>}} / IBM

{{<slideshare efLeWADDGXz14D>}}

論文: http://jmlr.org/proceedings/papers/v48/xiong16.html

> Neural network architectures with memory and attention mechanisms exhibit certain reason- ing capabilities required for question answering. One such architecture, the dynamic memory net- work (DMN), obtained high accuracy on a variety of language tasks. However, it was not shown whether the architecture achieves strong results for question answering when supporting facts are not marked during training or whether it could be applied to other modalities such as images. Based on an analysis of the DMN, we propose several improvements to its memory and input modules. Together with these changes we introduce a novel input module for images in order to be able to answer visual questions. Our new DMN+ model improves the state of the art on both the Visual Question Answering dataset and the bAbI-10k text question-answering dataset without supporting fact supervision.

* Memory Network内のMemory Moduleを改良した
* テキストではなく、画像を用いたQAタスクでも精度が出た

{{<tweet 756047518291460096>}}
{{<tweet 756050102670598144>}}
{{<tweet 756050917686816768>}}
{{<tweet 756051774436356096>}}

## Generative Adversarial Text to Image Synthesis
廣芝和之さん ({{<twitter hiho_karuta>}}) / ドワンゴ

{{<niconare kn1626>}}

論文: http://jmlr.org/proceedings/papers/v48/reed16.html

> Automatic synthesis of realistic images from text would be interesting and useful, but current AI systems are still far from this goal. However, in recent years generic and powerful recurrent neural network architectures have been developed to learn discriminative text feature representations. Meanwhile, deep convolutional generative adversarial networks (GANs) have begun to generate highly compelling images of specific categories such as faces, album covers, room interiors and flowers. In this work, we develop a novel deep architecture and GAN formulation to effectively bridge these advances in text and image modeling, translating visual concepts from characters to pixels. We demonstrate the capability of our model to generate plausible images of birds and flowers from detailed text descriptions.

* GANのアーキテクチャを応用し、 文章から画像を生成することができた
* 文章だけでは表せない情報は、スタイル、という概念を用いて吸収した

{{<tweet 756057271877050369>}}
{{<tweet 756058225657511936>}}

## Deep Speech 2 : End-to-End Speech Recognition in English and Mandarin

西鳥羽二郎さん ({{<twitter jnishi>}}) / Preferred Infrastructure

{{<slideshare z0e4lCCp712kue>}}

論文: http://jmlr.org/proceedings/papers/v48/amodei16.html

> We show that an end-to-end deep learning approach can be used to recognize either English or Mandarin Chinese speech–two vastly different languages. Because it replaces entire pipelines of hand-engineered components with neural networks, end-to-end learning allows us to handle a diverse variety of speech including noisy environments, accents and different languages. Key to our approach is our application of HPC techniques, enabling experiments that previously took weeks to now run in days. This allows us to iterate more quickly to identify superior architectures and algorithms. As a result, in several cases, our system is competitive with the transcription of human workers when benchmarked on standard datasets. Finally, using a technique called Batch Dispatch with GPUs in the data center, we show that our system can be inexpensively deployed in an online setting, delivering low latency when serving users at scale.

* End to Endの音声認識モデルを構築し、人手による書き起こしよりも高い精度を得た
* 異なる言語や、雑音のあるなしにも対応可能なモデルとなった

{{<tweet 756065132116008961>}}
