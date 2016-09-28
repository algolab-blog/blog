+++
draft = false
tags = [
  "speech-recognition",
  "amazon-echo",
  "raspberry-pi"
]
title = "AlexaスキルとLambdaファンクションはどのように連携しているか"
authors = "kawahito"
date = "2016-09-28T16:26:57+09:00"
+++

こちらの記事の続きとなります。  
[Alexa Skills KitをAWS Lamdaから使う]({{<ref "post/2016/08/29/alexa-skills-kit.md">}})

前回はサンプルとして用意されている「Color Expert」のAlexaスキルをLambdaファンクションを利用して動かしてみました。  
今回は「Color Expert」を例としてAlexaスキルとLambdaファンクションがどのように連携しているか説明したいと思います。

## 概念図
{{<img_rel "flow.png">}}

&nbsp;

まず、スキルの起動から一連のやり取り（正常系）を表した図が上記のようになります。  

大きな構造として、Alexaの中にスキル (青色) がいくつもあるイメージをしてください。各スキルで実行できる処理はIntent (赤色) として定義されます。  

それでは順を追って、スキル起動 （①〜④）、MyColorIsIntent （⑤〜⑧）、WhatsMyColorIntent （⑨〜⑫）の3つに分けて説明していきます。

## スキル起動 （①〜④）
ユーザが「Alexa, ask ○○○」と話しかけることで処理が始まります。○○○の部分はスキル名となります。
今回の場合は「Color Expert」 なので、下記のようになります。なお、このスキル名はAlexaが持っている全てのスキルを通じてユニークである必要があります。

> __ユーザ:__「Alexa, ask color expert」

Alexaがリクエスト①の音声をテキストに変換し、該当するスキルの起動リクエスト②がLambdaに送られます。その後、起動メッセージを含んだレスポンス③がAlexaに返り、Alexaがその起動メーセージを音声に変換し下記の応答④が返ります。
この一連の流れでColor expertのスキルが起動します。

> __Alexa:__ 「Welcome to the Alexa Skills Kit sample. Please tell me your favorite color by saying, my favorite color is red」

## MyColorIsIntent （⑤〜⑧）
次にAlexaの言うとおり下記のように話しかけてみます（⑤）。

> __ユーザ:__ 「My favorite color is blue」

このとき予め設定されているどの Intent かを判断し、入力である「blue」を slots にセットします。この情報はJsonに変換され、Lambda にリクエスト⑥がされることになります。ちなみに、slots にセットされる情報は音声入力の精度を高めるために Custom Slot Types で定義した情報が参照されて決まります。
Lambdaリクエスト⑥は具体的に下記のようになります。

```json:lambda_request
{
  "session": {
    "sessionId": "SessionId.xxx",
    "application": {
      "applicationId": "amzn1.ask.skill.xxx"
    },
    "attributes": {},
    "user": {
      "userId": "amzn1.ask.account.xxx"
    },
    "new": false
  },
  "request": {
    "type": "IntentRequest",
    "requestId": "EdwRequestId.xxx",
    "locale": "en-US",
    "timestamp": "2016-09-10T10:30:30Z",
    "intent": {
      "name": "MyColorIsIntent",
      "slots": {
        "Color": {
          "name": "Color",
          "value": "blue"
        }
      }
    }
  },
  "version": "1.0"
}
```

Lambdaは上記リクエスト⑥を受け取り、予めNode.jsなどのソースコードで定義されている処理を動かします。ソースコードの一部を見てみると、下記で「MyColorIsIntent」を判別し、 `setColorInSession()` で処理がされることになります。

```javascript:function_onIntent
function onIntent(intentRequest, session, callback) {
    console.log("onIntent requestId=" + intentRequest.requestId +
        ", sessionId=" + session.sessionId);

    var intent = intentRequest.intent,
        intentName = intentRequest.intent.name;

    if ("MyColorIsIntent" === intentName) {
        setColorInSession(intent, session, callback);
    } else if ("WhatsMyColorIntent" === intentName) {
        getColorFromSession(intent, session, callback);
    } else if ("AMAZON.HelpIntent" === intentName) {
        getWelcomeResponse(callback);
    } else if ("AMAZON.StopIntent" === intentName || "AMAZON.CancelIntent" === intentName) {
        handleSessionEndRequest(callback);
    } else {
        throw "Invalid intent";
    }
}
```

``setColorInSession()``のソースコードも見てみます。

```javascript:function_setColorInSession
function setColorInSession(intent, session, callback) {
    var cardTitle = intent.name;
    var favoriteColorSlot = intent.slots.Color;
    var repromptText = "";
    var sessionAttributes = {};
    var shouldEndSession = false;
    var speechOutput = "";

    if (favoriteColorSlot) {
        var favoriteColor = favoriteColorSlot.value;
        sessionAttributes = createFavoriteColorAttributes(favoriteColor);
        speechOutput = "I now know your favorite color is " + favoriteColor + ". You can ask me " +
            "your favorite color by saying, what's my favorite color?";
        repromptText = "You can ask me your favorite color by saying, what's my favorite color?";
    } else {
        speechOutput = "I'm not sure what your favorite color is. Please try again";
        repromptText = "I'm not sure what your favorite color is. You can tell me your " +
            "favorite color by saying, my favorite color is red";
    }

    callback(sessionAttributes,
         buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
}
```

`sessionAttributes` に `favoriteColor` をセットし、ここで書かれているレスポンスの文言などはJsonに変換されて⑦としてAlexaに返されることになります。
その後、Alexaがこのレスポンス⑦を受取り、下記のように返答⑧が返ります。

__入力を正しく受け取れた場合__

> __Alexa:__ 「I now know your favorite color is red. You can ask me. your favorite color by saying, what's my favorite color?」

__入力を正しく受け取れなかった場合__

> __Alexa:__ 「I'm not sure what your favorite color is. Please try again」

ちなみに、正しく受け取れた場合のレスポンス⑦の内容は下記になります。入力を正しく受け取れた場合は⑨の流れに進みます。正しく受け取れなかった場合は⑤のもう一度好きな色を教える流れになります。

```json:lambda_response
{
  "version": "1.0",
  "response": {
    "outputSpeech": {
      "type": "PlainText",
      "text": "I now know your favorite color is blue. You can ask me your favorite color by saying, what's my favorite color?"
    },
    "card": {
      "content": "SessionSpeechlet - I now know your favorite color is blue. You can ask me your favorite color by saying, what's my favorite color?",
      "title": "SessionSpeechlet - MyColorIsIntent",
      "type": "Simple"
    },
    "reprompt": {
      "outputSpeech": {
        "type": "PlainText",
        "text": "You can ask me your favorite color by saying, what's my favorite color?"
      }
    },
    "shouldEndSession": false
  },
  "sessionAttributes": {
    "favoriteColor": "blue"
  }
}
```

## WhatsMyColorIntent (⑨〜⑫)
ここもIntentの処理になるので、⑤〜⑧と処理の流れは同じになります(リクエストとレスポンスの具体的な内容は割愛)。ここでもAlexaの言うとおり下記のように話しかけてみます(⑨)。

> __ユーザ:__「What's my favorite color?」

そうすると⑥と同様にどのIntentかを判断し、WhatsMyColorIntentのLambdaリクエスト⑩が送られます。
⑦と同様に `onIntent()` の判別処理がされ、今度は `getColorFromSession()` に進みます。

```javascript:function_getColorFromSession
function getColorFromSession(intent, session, callback) {
    var favoriteColor;
    var repromptText = null;
    var sessionAttributes = {};
    var shouldEndSession = false;
    var speechOutput = "";

    if (session.attributes) {
        favoriteColor = session.attributes.favoriteColor;
    }

    if (favoriteColor) {
        speechOutput = "Your favorite color is " + favoriteColor + ". Goodbye.";
        shouldEndSession = true;
    } else {
        speechOutput = "I'm not sure what your favorite color is, you can say, my favorite color " +
            " is red";
    }

    callback(sessionAttributes,
         buildSpeechletResponse(intent.name, speechOutput, repromptText, shouldEndSession));
}
```

`favoriteColor` がセット済みであればそれを含んだメッセージを作り、なければ再度好きな色を聞くメッセージを返すという流れになります。⑪としてレスポンスを返し、Alexaが音声化して下記のように応答⑫をします。

__好きな色がセットされている場合__

> __Alexa:__ 「Your favorite color is blue. Goodbyde.」

__好きな色がセットされてない場合__

> __Alexa:__ 「I'm not sure what your favorite color is, you can say, my favorite color is red」

なお、正常系の場合、ソースコードにあるように `shouldEndSession ` を `true` としているので、ここでセッションを終了し Color expert のスキルは終了となります。

## まとめ
- 概念図とソースコードを交えてAlexaスキルとLambdaファンクションがどのように機能しているかを説明しました。
- AlexaスキルではユーザからのメッセージとIntentとの対応付けを制御し、Lambdaファンクションの方で各Intentの処理をする仕組みになっているのが分かりました。
- それでは、次回オリジナルのスキルを作ってみようと思います。
