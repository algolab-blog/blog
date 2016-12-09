+++
authors = "kawahito"
date = "2016-12-09T15:03:23+09:00"
draft = false
tags = [
  "tips"
]
title = "PhantomJSでPromiseが使えない場合の対処法 〜Can't find variable: Promise〜"
+++

Selenium + PhantomJS でDjangoアプリケーションのテストをしていたのですが、なぜか上手く動作しない箇所がありました。

原因としては、外部ライブラリが [Promise](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Promise) を用いており、PhantomJSがサポートしていないためで、[es6-promise](https://github.com/stefanpenner/es6-promise) を明示的に読み込ませることで解決しました。

以下に再現のためのサンプルコードを書いてみます。

## サンプルコード
以下の2つのファイルを用意します。`test.html`は`http://localhost/test.html`で読み込めることを前提としています。

test.html
```
<!DOCTYPE html>
<script>
  var hoge = 1;
  console.log(Promise);
  var hoge = 2;
</script>
```

test.py
```
from selenium import webdriver

driver = webdriver.PhantomJS()
driver.get('http://localhost/test.html')
hoge = driver.execute_script('return hoge')
print(hoge)
```

`test.py`を実行します。

```
$ python test.py
1
```

`hoge`の値が`1`であり、`console.log(Promise);`以降処理が行われていないことがわかります。  
`ghostdriver.log`にログが出力されるので、みてみると下記のエラーが出力されていました。
```
[ERROR - 2016-12-09T05:54:22.556Z] Session [eee84f50-bdd3-11e6-87a5-f36dec782eab] - page.onError - msg: ReferenceError: Can't find variable: Promise
```

続いて、`test.html`で`es6-promise`を明示的に読み込ませるように修正します。
```
<!DOCTYPE html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.0.5/es6-promise.auto.js"></script>
<script>
  var hoge = 1;
  console.log(Promise);
  var hoge = 2;
</script>
```

```
$ python test.py
2
```

きちんと処理が行われるようになりました。

GitHub上でも下記の議論が行われており、`ES6` のサポートが本体に導入されることを待つばかりです。  
https://github.com/ariya/phantomjs/issues/12401
