+++
authors = "kawahito"
date = "2016-08-24T15:48:58+09:00"
draft = false
tags = ["development-environment"]
title = "VPNサーバのパブリックIPをDNSに登録する 〜Raspberry Pi上で定期実行〜"
+++

弊社オフィスではVPN環境を構築していますが、固定IPを取得していないため、パブリックIPが変わるたびにVPNサーバーの接続先を変更しなければならず面倒です。  
そこで、定期的にIPアドレスを取得し、DNSに登録するようにしています。  
ここでは、Raspberry Pi 上でAWS SDK for Python (Boto 3) を用いて定期実行させる手順をまとめます。


## AWS SDK for Python のインストールおよび設定
DNSはAWSのRoute53で管理しており、その操作のためにSDKを導入します。  
なお、Raspberry PiにはPython (2.7系) がデフォルトでインストールされているため、そのまま用います。  

```sh
$ sudo pip install boto3
```

続いて、Credentialを設定します。```YOUR_KEY```および```YOUR_SECRET```は環境に合わせて設定してください。  
(Route53へのアクセス権限があれば問題ありません)

```sh
$ vi ~/.aws/credentials
```

```sh
[default]
aws_access_key_id = YOUR_KEY
aws_secret_access_key = YOUR_SECRET
```

## DNS更新
DNS更新には```change_resource_record_sets```メソッドを使用します。  
詳細は、[公式ドキュメント](http://boto3.readthedocs.io/en/latest/reference/services/route53.html#Route53.Client.change_resource_record_sets) を参照してください。


## パブリックIPの取得
パブリックIPは、[httpbin.org](http://httpbin.org) にアクセスして取得します。  
レスポンスとしては以下のようなものが返ってきます。

```sh
$ curl http://httpbin.org/ip
{
    "origin": "xxx.xxx.xxx.xxx"
}
```

## スクリプト
以上を踏まえて、スクリプトを書いていきます。  
``DOMAIN``および``HOST``は環境に合わせて書き換えてください。下記では``hoge.example.com``を登録する例としています。


```python
# -*- coding: utf-8 -*-

import json
import urllib2

import boto3

DOMAIN = 'hoge'
HOST = 'example.com'
TTL = 300

# パブリックIPアドレスの取得
response = urllib2.urlopen('http://httpbin.org/ip')
json_str = response.read()
ip_address = json.loads(json_str)['origin']

# AWS SDK Client
client = boto3.client('route53')

# hosted_zone_idの取得
hosted_zones = client.list_hosted_zones()['HostedZones']
hosted_zone_id = filter(lambda h: h['Name'] == HOST + '.', hosted_zones)[0]['Id']

# 更新内容
change_batch = {
    'Changes': [
        {
            'Action': 'UPSERT',
            'ResourceRecordSet': {
                'Name': DOMAIN + '.' + HOST + '.',
                'Type': 'A',
                'TTL': TTL,
                'ResourceRecords': [
                    {'Value': ip_address}
                ]
            }
        }
    ]
}

# 更新
client.change_resource_record_sets(
    HostedZoneId = hosted_zone_id,
    ChangeBatch = change_batch
)
```

あとは、上記のスクリプトを```cron```に登録するなどして、定期実行させれば完了です。
