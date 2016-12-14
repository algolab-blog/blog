+++
draft = false
tags = [
  "speech-recognition",
  "amazon-echo",
  "raspberry-pi"
]
series = "amazon-echo"
title = "Alexa Skills KitをAWS Lamdaから使う"
authors = "kawahito"
date = "2016-08-29T16:10:04+09:00"
+++

前回はRaspberry PiからAVS (Alexa Voice Services) を使ってみましたが、今回は、Alexa Skills Kitを使ってみたいと思います。

## 完成したもの
Alexaが自分の好みの色を覚えてくれるようになりました。
{{<youtube HAOPIuFDdik>}}

## Alexa Skill Kitとは
AVSには好みの機能を追加できるSkillという機能があり、「カスタムスキル」と「スマートホームスキル」の2種類を登録することができます。

https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/understanding-the-different-types-of-skills

### カスタムスキル
{{<img_rel "custom-skill.png">}}

* ピザを注文したり、タクシーを呼んだり色々なことができる
* Invocation Name (スキルの呼び名) で呼び出す
* リクエストは「intent」としてマッピングされる
 - ピザの注文 &rarr; OrderPizza intent

### スマートホームスキル
{{<img_rel "smart-home-skill.png">}}

* Smart home device (灯りやエアコンなど) を操作できる
* Invocation Nameで呼び出すのは不要 

## 今回作るもの
公式の [ドキュメント](https://developer.amazon.com/appsandservices/solutions/alexa/alexa-skills-kit/docs/developing-an-alexa-skill-as-a-lambda-function) と [ポスト](https://developer.amazon.com/public/community/post/TxDJWS16KUPVKO/New-Alexa-Skills-Kit-Template-Build-a-Trivia-Skill-in-under-an-Hour) を参考に、今回は「Color Expert」のSkillを使ってみます。  
Alexa SkillsはLambdaファンクション上で実行されるので、AWS LambdaとAlexa Skillsの設定が必要になります。


## AWS Lambdaの作成
AWSマネジメントコンソールにログインし、[Lambda](https://console.aws.amazon.com/lambda/home) のページを開きます。

リージョンがバージニア北部(US East (N. Virginia))になっていることを確認し、なっていなければ変更します。Lambdaファンクションを利用してAlexa Skillsを使うのに、現在他のリージョンはサポートされていません。

{{<img_rel "alexa-skills-kit-1.png">}}

``Create a Lambda function``をクリックするとBlueprint一覧画面になります。ここから``alexa-skills-kit-color-expert``を選択します。

{{<img_rel "alexa-skills-kit-2.png">}}

Lambdaファンクションを呼び出すトリガーの選択画面になるので、灰色の点線のボックスをクリックし、``Alexa Skills Kit``を選び``Next``をクリックします。

{{<img_rel "alexa-skills-kit-3.png">}}

Lambdaファンクションの構成画面になります。Nameには「colorExpertTest」などと入力します。

RoleにはLambdaを使うのが初めてであれば、``Create new role from template(s)``から新しくRoleを作成し、Role Nameには「lambda_basic_execution」などと入力します。

Policy templatesには``AMI read-only permissions``などを選択すればOKです。

Lambda function codeなど他の項目はデフォルトのままでも問題ありません。

一通り入力・変更が終わったら``Next``をクリックします。

そうすると、下記のような確認画面になります。問題なければ``Create function``をクリックします。

{{<img_rel "alexa-skills-kit-4.png">}}

トリガーのテスト画面になります。
``Test``をクリック &rarr; ``Alexa Start Session``を選択 &rarr; ``save and test``をクリックと進むとTestが走ります。
実行結果がSuceededとなること、ログ出力に先ほどのLambda function codeの出力結果が表示されていればOKです。

{{<img_rel "alexa-skills-kit-5.png">}}

これで作成は完了です。最後にLambdaファンクションの呼び出し先となるARNをメモしておきます。上記スクリーンショットで右上の一部灰色でマスクしている文字列です。

## Alexa Skillの作成
Raspberry Piが登録されているアカウントでAmazon Developer Consoleにログインし、[Alexa](https://developer.amazon.com/edw/home.html) のページに進みます。

Alexa Skills Kitの``Get Started``をクリックします。

{{<img_rel "alexa-skills-kit-6.png">}}

``Add a New Skill``から新規にSkillを登録します。実際に話しかけて呼び出すときの名前となるInvocation Nameには「color expert」と入力して、``Next``をクリックします。

{{<img_rel "alexa-skills-kit-7.png">}}

Interaction Modelの定義画面になります。これがAlexaに話しかけてやり取りをする内容になります。今回は[公式ドキュメント](https://developer.amazon.com/appsandservices/solutions/alexa/alexa-skills-kit/docs/developing-an-alexa-skill-as-a-lambda-function)のとおりにIntent Schame, Custom Slot Types, Sample Utterancesを下記のようにします。

{{<img_rel "alexa-skills-kit-8.png">}}

Intent_Schema
```json
{
  "intents": [
    {
      "intent": "MyColorIsIntent",
      "slots": [
        {
          "name": "Color",
          "type": "LIST_OF_COLORS"
        }
      ]
    },
    {
      "intent": "WhatsMyColorIntent"
    },
    {
      "intent": "AMAZON.HelpIntent"
    }
  ]
}
```

Custom_Slot_Type
```json
LIST_OF_COLORS
```

Custom_Slot_Type_Values
```json
green
red
blue
orange
gold
silver
yellow
black
white
```

Sample_Utterances
```json
WhatsMyColorIntent what's my favorite color
WhatsMyColorIntent what is my favorite color
WhatsMyColorIntent what's my color
WhatsMyColorIntent what is my color
WhatsMyColorIntent my color
WhatsMyColorIntent my favorite color
WhatsMyColorIntent get my color
WhatsMyColorIntent get my favorite color
WhatsMyColorIntent give me my favorite color
WhatsMyColorIntent give me my color
WhatsMyColorIntent what my color is
WhatsMyColorIntent what my favorite color is
WhatsMyColorIntent yes
WhatsMyColorIntent yup
WhatsMyColorIntent sure
WhatsMyColorIntent yes please
MyColorIsIntent my favorite color is {Color}
```

次にEndpointなどの設定画面になります。先ほどメモしておいたARNを入力します。

{{<img_rel "alexa-skills-kit-9.png">}}

次にTest画面になります。Enter Utteranceに先ほどSample Utteranceに定義した文章を入力して``Ask color expert``をクリックします。するとLambdaで処理が実行されて返答される文章などを含んだレスポンスが返ってきます。

{{<img_rel "alexa-skills-kit-10.png">}}

残りの設定項目に Publishing infomation, Privacy & Compliance がありますが、これらはAlexa Skillをpubulishingするときに必要で、手元の実機での実行には必要ないので今回は割愛します。

## 動作確認
まずAmazon Developer Consoleと同じアカウントでAmazon Alexaにログインして[Skill一覧画面](http://alexa.amazon.com/spa/index.html#skills/your-skills)から先ほど作成したSkillがあることを確認します。

{{<img_rel "alexa-skills-kit-11.png">}}

あとは冒頭の動画のように話しかけて動作するか確認します。

## 次回予告
次回はソースコードの中身を見てみます。  
