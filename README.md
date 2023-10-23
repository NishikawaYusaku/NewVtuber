# Chaos（サービス名未定）

## サービス概要
Vtuberはファンの獲得、ファンはまだ知らないVtuber、あるいはVtuber同士の出会いが出来ることを目指した、配信者と視聴者からなるサービスです。

## 想定されるユーザー層
ファンを増やしたいVtuber、好きなVtuberを見つけたいファン、Vtuber文化が好きな人

## サービスコンセプト
Vtuberという文化が登場してから7年ほどが経過し、現在では数えきれないほどのVtuberとファンがいます。  
そのため、お互いに相手に知られていない、知らないという必然的な現状があります。  
しかし、埋もれている魅力的なVtuber、もっと自分の好みに刺さるVtuberはいるはずです。  
それを少しでも改善する、Vtuberとファンの出会いの場にしたいと考えています。
また、Vtuber同士も気の合う相手が見つけられる場になることを目指します。

既存サービスがあり、そこでは多くのVtuberが登録されています。  
しかし検索条件が少ないため、ファンはご自身の気になる条件で検索ができないと感じました。  
また、掲載ページ数も多いため、その状態で中々好みに合う方を見つけることは簡単ではないと思います。  
それらの理由から、当サービスでは以下の2つをこのサービスの要とします。  
・Vtuberのプロフィール設定/閲覧  
・チャンネル登録者数、配信場所、配信頻度など多様な条件によるVtuberの検索  
Vtuberはご自身のプロフィールを設定し、ファンは多くの条件で検索をできるようにします。  
それにより見つけてもらえない・見つけられないの問題の低減に近づくと考えます。  

私はVtuberが好きです。  
ただ、多くいるVtuberの中からより自分の好みに合う方を見つけるためにこのサービスを作ります。  

## 実装を予定している機能
### MVP
* アカウント登録
* ログイン
* 配信者一覧
* 検索機能
* いいね機能
* プロフィール登録（配信者のみ）
* プロフィール閲覧
* コメント機能
* 好みにあった配信者のレコメンド機能（視聴者のみ）

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