# itc2auk
## 説明
時間割編成問題を記述するフォーマットの1つにITC2019で提案されたXMLフォーマット（ITCフォーマット）がある．
一方，RubyのDSLとして，ITCフォーマットを基にした時間割編成問題を記述するフォーマットであるAUKが提案されている．
本リポジトリには，ITCフォーマットとAUKの記述量を比較するためのプログラムが含まれている．
## itc2auk.rb
ITCフォーマット（XML）をAUKのフォーマットに変換する．
変換されたAUKファイルはauk/以下に生成される．

使用方法:
```
$ ruby itc2auk.rb (filename)
```

## tokenizer.rb
ITCフォーマットおよびAUKの記述量を算出する．
ここで，記述量とは，すべての字句のうち情報を持たない字句を除いたものの総数である．

使用方法:
```
$ ruby tokenizer.rb (filename)
```

## 使い方
1. AUKに変換するITCフォーマットを[ITC2019のWebページ](https://www.itc2019.org/)からダウンロードし，itc/以下に置く．
1. itc2auk.rbを用いてITCフォーマットをAUKに変換する．
  2. ```$ ruby itc2auk.rb (filename)```
1. tokenizer.rbを用いてITCフォーマットおよびAUKの記述量を算出する．
  2. ```$ ruby tokenizer.rb (filename)```
