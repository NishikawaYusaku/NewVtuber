# Chaos（サービス名未定）

## サービス概要
Vtuberはファンの獲得、ファンはまだ知らないVtuberとの出会いが出来ることを目指したサービスです。

## 想定されるユーザー層
ファンを増やしたいVtuber、好きなVtuberを見つけたいファン、Vtuber文化が好きな人

## サービスコンセプト
Vtuberという文化が登場してから7年ほどが経過し、現在では数えきれないほどのVtuberとファンがいます。  
そのため、お互いに相手に知られていない、知らないという必然的な現状があります。  
しかし、埋もれている魅力的なVtuber、もっと自分の好みに刺さるVtuberはいるはずです。  
それを少しでも改善する、Vtuberとファンの出会いの場にしたいと考えています。

サービスの内容としましては、以下の通りに考えています。  
・ユーザー（視聴者またはVtuberご本人）が自分の好きなVtuberのプロフィールを設定・編集する。    
・別のユーザーが自分のこだわる条件でVtuberの検索をできるようにします。    
・検索条件に一致した、他のユーザが設定したVtuber一覧が表示されます。  
・ユーザーはその中からご自身の気になるVtuberのプロフィールを閲覧します。  

既存サービスがあり、そこでは多くのVtuberが登録されています。  
しかし検索条件が少ないため、ファンはご自身の気になる条件で検索ができないと感じました。  
また、掲載ページ数も多いため、その状態で中々好みに合う方を見つけることは簡単ではないと思います。  
それらの理由から、当サービスではチャンネル登録者数、配信場所、配信頻度など多様な条件によるVtuberの検索ができるようにします。  

今回このサービスを作る理由の1つは、私自身がVtuberが好きだからです。   
普段知らないVtuberを知るきっかけとしてX（旧Twitter）、配信サイトの2つが主ですがどちらも共通して「偶然知る」ということがあると感じました。  
そのため、逆に自分か自分から条件を指定して好みに合うVtuberを探すことができる、必然的に知れるようなサービスがあると嬉しいので作ります。  

## 実装を予定している機能
### MVP
* アカウント登録
* ログイン
* 配信者一覧表示
* 検索機能
* いいね機能
* いいね削除機能
* プロフィール設定
* プロフィール編集
* プロフィール閲覧
* コメント作成機能
* コメント編集機能
* コメント削除機能
* 好みにあった配信者のレコメンド機能

### その後の機能
* マルチ検索
* いいねの通知

## 使用予定の技術
* Ruby 3.2.2
* Ruby on Rails 7.1.1
* JavaScript
* Bootstrap
* MySQL
* recommendify
* Heroku

## 画面遷移図
Figma：https://www.figma.com/file/C3glur5TElWMfdBr5OtMs3/%E5%90%84%E7%94%BB%E9%9D%A2%E3%81%AEUI?type=design&node-id=41%3A2573&mode=design&t=GgsmpW7AMXCWkRsW-1

## ER図
[![ER図](https://i.gyazo.com/decb7dba6735d7275f3032eb4cc74bd5.png)](https://gyazo.com/decb7dba6735d7275f3032eb4cc74bd5)