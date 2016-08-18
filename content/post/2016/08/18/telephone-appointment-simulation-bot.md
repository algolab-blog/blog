+++
author = "Shinpei Kawahito"
date = "2016-08-18T15:20:16+09:00"
draft = false
title = "テレアポ模擬トレーニングBot 〜コミュニケーション教育ツールとしてのチャットボットの活用可能性〜"
+++

{{<img_rel "cover.png">}}

LINEがBOT API、FacebookがMessenger Platformを発表してから数ヶ月たちました。  
これまでに数々のチャットボットがリリースされていますが、まだ活用方法を模索している段階かと思います。

その中で、コミュニケーション教育ツールとしての活用可能性があるのではないかと考え、実験的に「テレアポ模擬トレーニングBot」を [TORiX](http://www.torix-corp.com/) さんと共同開発させていただきました。

今回は、このBotの概要と、開発に至った経緯について書きたいと思います。

## テレアポ模擬トレーニングBotとは
{{<img_rel "story.png">}}

ストーリー形式で、テレアポを擬似体験することのできるコンテンツです。下記ボタンから体験できます。

{{<fb_messageus "131078513971096" "1771482106414711">}}

ボタンが動作しない場合は、下記ページからメッセージを送ってみてください。  
https://www.facebook.com/1771482106414711/

## 開発の経緯
コミュニケーション領域の教育においては、疑似的にでも経験を積むことが一番スキルが身につく手段であると考えていますが、
書籍や動画等のコンテンツではそれを体験することが困難です。

その中で、チャットボットを用いれば容易に実現できるのではないか、と考えたのが開発のきっかけです。  

実際に、テレアポ模擬トレーニングBotは1日もかからず実装することができました。  
(ストーリーを考える時間は別途必要です)

## コミュニケーション教育ツールとしての可能性
今回は題材としてテレアポを取り上げましたが、他にも応用可能性はあると考えています。

例えば、[board](https://the-board.jp/) を展開する [VELC](http://www.velc.co.jp/about/) さんは、カスタマーサポートの教育にBotを用いていると語っています。

> そこで重要になってくるのが教育です。それに使っているのが、チャットツールである「Slack（スラック）」のbotです。  
Slack上で「ok board」と打ち込むと、FAQからSlackに質問だけがランダムに飛んでくるようになっています。スタッフには空き時間にそれを使って回答文を作成する練習をしてもらい、後で僕がレビューをする。

引用元: [「カスタマーサクセス」を意識したことはない。自然に神対応を実現した、CSの理想形](https://seleck.cc/article/475)

## おわりに
今回は、チャットボットを「チャットUIを用いたインタラクティブなアプリを簡単に作れるツール」として捉え、コミュニケーション教育ツールとしての活用可能性についてお届けしました。  

まだまだ可能性を秘めていると思いますので、今後も注目していきたいと思います。