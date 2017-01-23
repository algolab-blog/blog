+++
date = "2017-01-23T17:32:10+09:00"
draft = false
tags = [
  "tips"
]
title = "FetchRSS + Slack で快適な情報収集ライフを送る"
authors = "kawahito"
+++

{{<img_rel "fetchrss-top.png">}}

弊社では、Slackの`/feed`コマンドを用いて、ニュースなどの情報を一元化していますが、媒体によってはRSSフィードが提供されていないものもあります。 今回は、そんな場合に役に立つ [FetchRSS](http://fetchrss.com) を紹介します。  

## 気になるお値段
基本的には有料プランでないと恩恵を受けられません (無料版では作成したRSSが7日間で消えてしまうため)。ただ、ほとんどのケースにおいて$9.95内に収まると思いますので、情報収集が楽になることを考えると安いものでしょう。

{{<img_rel "fetchrss-price.png">}}

## 使い方
### 会員登録
無料プランの場合も会員登録が必要になるので、登録しておきます。

### URL入力
以降、当ブログのRSSを取得するとして進めていきます。
まず、トップページから取得したいページのURLを入力します。 新着記事が一覧で並んでいるページが望ましいです。当ブログの場合は下記URLとなります。
{{<img_rel "fetchrss-howto-1.png">}}

すると、以下のようなページに遷移すると思います。このページでは取得するコンテンツを指定していきます。最低限「News Item」「Headline」「Content」の3つを指定する必要があります。
{{<img_rel "fetchrss-howto-2.png">}}

### News Item 選択
「News Item」では、下図の青色の線のように、記事を構成する要素の一番外側を選択します。
{{<img_rel "fetchrss-howto-3.png">}}

### Headline 選択
「Headline」ではタイトル部分を選択します(緑色の枠)。
{{<img_rel "fetchrss-howto-4.png">}}

### Content 選択
「Content」では文章部分を選択します（赤色の枠）。文章部分がない場合は、「Headline」と同じ領域で構いません。
{{<img_rel "fetchrss-howto-5.png">}}

## RSS生成
「Content」まで正しく選択できると、画面右側に下図のようなプレビューが生成されると思います。内容が問題なければ、「Generate RSS」を押してRSSを生成します。
{{<img_rel "fetchrss-howto-6.png">}}

うまくRSSが生成できました。それでは快適な情報収集ライフを！
{{<img_rel "fetchrss-howto-7.png">}}
