+++
authors = "kawahito"
date = "2016-12-07T18:15:27+09:00"
draft = false
tags = [
  "speech-recognition",
  "amazon-echo",
]
title = " Alexa Skill (Amazon Echo) を公開したので開発上のポイントをまとめてみる 〜Birthday Reminder〜"
+++

こちらの記事の続きとなります。  
[AlexaスキルとLambdaファンクションはどのように連携しているか]({{<ref "post/2016/09/28/alexa-color-expert.md">}})

今回は、オリジナルのスキルを作ってマーケットに公開したので、その中で色々分かったことをまとめてみます。

## 開発上の制約
### 自由な文章の認識は難しい
これが一番困った点でした。基本的には、テンプレートのような形であらかじめ登録しておいた文章や単語しか認識がうまくいかないため、今のところ、限定的な用途でしか利用できなさそう、という印象です。

ただ、人名や都市名など、ある程度想定できる単語を認識する枠組み (Slot Type) は用意されています。  
```sh
例) AMAZON.US_FIRST_NAME, AMAZON.US_CITY, AMAZON.DATE
```

ですので、これらを利用するシチュエーションでは比較的柔軟なスキルを作成することができそうです。

### データの永続化には別途仕組みが必要
Alexa Skillを起動している最中（セッション内) ではデータ保持ができますが、セッションをまたいでデータを保持するには、自前で永続化する機構を作らないといけません。

### 使用できる言語は、英語およびドイツ語のみ
他の言語はまだサポートされていません。

これらの制約や仕様がある中で、作りたいスキルをどう実現できそうか考えることがまず必要です。

## Birthday Reminder
{{<img_rel "birthday-reminder.png">}}

当初、記憶させたことをなんでも取り出せるスキルを作ろうと考えていましたが、上記のように難しいことがわかったため、今回は誕生日に限定して、記憶や取り出しのできるスキルを作ることにしました。

[こちら](http://alexa.amazon.com/spa/index.html#skills/dp/B01N8USH7G/?ref=skill_dsk_skb_sr_0) からインストール可能です。

本スキルでは、以下のようなやり取りをすることができます。

### 誕生日を登録する
> User: "Tom's birthday is July seven."  
> Skill: "I now know Tom's birthday is July seven."

### 登録した人の誕生日を調べる
> User: "When was Tom born on?"  
> Skill: "Tom's birthday is Jul seven."

### 登録した誕生日に生まれた人を調べる
> User: "Who were born on July seven?"  
> Skill: "Tom were born on Jul seven."


人名と誕生日の認識には、Slot Typeの枠組みを利用しました。人名には `AMAZON.US_FIRST_NAME` を使用し、人名だけでなく母親や兄弟の誕生日も登録できるように`my mother`, `my brother`なども `AMAZON.US_FIRST_NAME` を拡張して利用できるようにしました。誕生日の日付の認識では `AMAZON.DATE` を使用しています。

## データの永続化
今回のスキルでは、誕生日というデータを永続化して次回のセッションでも取り出すことができるようにする必要がありました。 単純に同一セッションの保存であれば、前回の記事でも紹介したように、`sessionAttributes`を利用することができます。ただし、次回以降のセッションでも利用しようとするには何かしらのDBへの保存が必要です。

今回は「人」に対する「誕生日」という Key-Value のような特定のデータの引き方になることから、DynamoDBを選択しました。

## 保存するデータ
今回のスキルでは、以下のようなデータを保持しています。

```json
{
	"user_id": "amzn1.ask.account.XXX...",
 	"person": "Tom",
 	"birthday": "Jul 07",
},
{
	"user_id": "amzn1.ask.account.XXX...",
 	"person": "Peter",
 	"birthday": "Dec 04",
}
```

`user_id`はユーザのAmazonアカウントに紐づくIDです。`person`は登録した人の名前、`birthday`は登録した人の誕生日です。

## DynamoDBのスキーマ構造
上記データを、具体的には次のようなスキーマ構造としてDynamoDBに格納しています。

* プライマリーキー
 * パーティションキー: `user_id`
 * ソートキー: `person`
* その他属性
 * `birthday`
* セカンダリインデックス
 * パーティションキー: `user_id`
 * ソートキー: `birthday`

`user_id`と`person`をプライマリーキーにすることで、登録した人の名前から誕生日を参照できるようにし、`user_id`と`birthday`をセカンダリインデックスとすることで、誕生日から人を参照できるようにしています。

## スキルの申請と審査
スキルを作り終わったら、あとは公開に必要なスキルの説明やスキルのアイコン画像、Privacy Policyの準備になります。

{{<img_rel "publishing-information.png">}}

申請をすると、2営業日ほどで結果が返ってきました。公式ドキュメントの [こちら](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/submission-testing-walk-through-tide-pooler-skill) にあるようなテスト項目を結構細かく実際に試してテストしている印象でした。指摘された箇所を修正して再申請して審査が通りました。

## まとめ
今回、Alexa Skillを作るにあたっての制約や設計で工夫した点、審査の過程などを紹介しました。基本的にはDBの設計周りは一般的なアプリケーションの設計と大きく変わらないと思います。

Alexa Skillのドキュメントは結構ありますが、細かいページへのサイトマップなどは用意されてないので、検索して見つけるか関連するページのフッター付近のリンクから辿るしかなかったのが若干厄介でした。今後、整備されることに期待です。

先日、テキストを音声で読み上げる [Amazon Polly](https://aws.amazon.com/polly/) が発表されましたが、こちらにも期待です。
