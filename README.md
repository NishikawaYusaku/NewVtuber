# にゅーぶい！
https://newvtuber.com/

[![にゅーぶい！のサムネイル](https://i.gyazo.com/3b76e916a6b7fa28466e3ce247c719c3.png)](https://newvtuber.com/)

## サービス概要
VTuberの発見と布教が出来るサービスで、下記を目指しています。<br>
　　視聴者 　：　自分が今まで知らなかった新しいVTuberとの出会い<br>
　　VTuber　：　新しい視聴者の獲得

## 想定ユーザー
・新しいVTuberを見つけたい視聴者<br>
・視聴者を増やしたいVTuber<br>
・VTuber文化が好きな人

## サービスコンセプト
最初のVTuberが誕生してから9年近くが経過し、現在では無数のVTuberと視聴者がいます。<br>
ゆえに、視聴者はそのVTuberを知らない、VTuberは自分の存在に気づいてもらえないという必然的な現状があります。<br>
しかし、自分の好みに刺さるVTuber、埋もれている魅力的なVTuberは多くいるはずです。<br>
実際私も配信サイトのおすすめ欄やSNSで偶然知って好きになったVTuberは少なくありません。<br>
そこで、自分がVTuberに対して気にする要素（性別や配信ジャンルなど）を指定して、好みに合ったVTuberを自分から見つけに行くサービスがあると楽しいと思いました。<br>
そのようなWebアプリを開発し、視聴者とVTuberの新しい出会いの場を提供したいと考えました。

## 機能
### 基本
* 認証（ユーザー登録、ログイン、ログアウト）
* ユーザー情報の変更（メールアドレス、パスワード、ユーザー名）
* いいね（登録、削除）
* コメント（投稿、編集、削除）

### 主要
* プロフィール設定（作成、編集）
* 検索（通常）
* 検索（詳細）
* 通知（いいねしたプロフィールの更新時）

#### ・プロフィール設定（作成、編集）
ログインした状態でヘッダーの設定ボタンを押します。<br>
<img width="1000" alt="プロフィール設定（作成、編集）の画像1" src="https://i.gyazo.com/fc14fc2a8645d22dbf2d033699a4828f.png">

設定するVTuberのお名前を入力して設定するボタンを押します。<br>
編集時はお名前の一部を入力すると自動補完で候補が表示されます。<br>
<img width="400" alt="プロフィール設定（作成、編集）の画像2" src="https://i.gyazo.com/1ae441c66ef162fdbd3405671cd65a48.png">

各プロフィール項目を入力して登録ボタンを押します。<br>
編集時は設定済みの各項目が入力された状態で表示されます。<br>
<img width="400" alt="プロフィール設定（作成、編集）の画像3" src="https://i.gyazo.com/8fb7d5f9af8702c3a21fddb7214b987f.png">

プロフィールの設定が完了します。<br>
<img width="800" alt="プロフィール設定（作成、編集）の画像4" src="https://i.gyazo.com/b0d0488e59a102e75ee46c5b0b5983e6.png"><br>
編集時はプロフィールページから設定ボタンを押すと、そのVTuberのお名前が入った状態でモーダルが表示されます。

#### ・検索（通常）
ヘッダーの検索欄に性別や配信内容など気になるワードを入力して検索ボタンを押します。<br>
<img width="1000" alt="検索（通常）の画像1" src="https://i.gyazo.com/53a1a29809d9a091fca72e4d098d1596.png">

検索結果が表示されます。<br>
<img width="1000" alt="検索（通常）の画像2" src="https://i.gyazo.com/d5abf7e8bcfd36af34153ac5e86a8b78.png">

タグで検索する際はプロフィールページのタグを押すことでもできます。<br>
<img width="1000" alt="検索（通常）の画像3" src="https://i.gyazo.com/77c993eccb8ad84d837733195dc9b9ad.png">

タグ検索の結果が表示されます。<br>
<img width="1000" alt="検索（通常）の画像4" src="https://i.gyazo.com/48424d97e2c1a579f99f694c135de6c9.png">

#### ・検索（詳細）
ヘッダーの詳細検索ボタンを押します。<br>
<img width="1000" alt="検索（詳細）の画像1" src="https://i.gyazo.com/6631b93a09d4d0979fad12a7e4e866a1.png">

好みに合わせて各項目を指定します。<br>
（チャンネル登録者数 / 動画数は配信サイトでYouTubeを選択した場合のみ選択可能になります）<br>
<img width="400" alt="検索（詳細）の画像1" src="https://i.gyazo.com/3cdb5b85570e22a47c172d89ebaa8b90.png">

検索結果が表示されます。<br>
<img width="1000" alt="検索（詳細）の画像1" src="https://i.gyazo.com/7ba1192283ae1792bc0e9ee8d4571864.png">

#### ・通知（いいねしたプロフィールの更新時）
ログイン済かつVTuberをいいねした状態でいます。<br>
<img width="1000" alt="通知（いいねしたプロフィールの更新時）の画像1" src="https://i.gyazo.com/381db8a1408604663789fe62394a08d4.png">

他のユーザーがそのVTuberのプロフィールを更新します。<br>
その結果、そのVTuberをいいねをした全ユーザーに通知が届き、ヘッダーの通知ボタンに色がつきます。<br>
<img width="1000" alt="通知（いいねしたプロフィールの更新時）の画像2" src="https://i.gyazo.com/131440d255b9078bfcff8124ac50d3f3.png">

通知ボタンを押すと更新されたVTuberの一覧が表示され、通知ボタンの色が消えます。<br>
通知メッセージを押すとプロフィールページに移動します。<br>
<img width="400" alt="いいねしたプロフィールの更新時）の画像3" src="https://i.gyazo.com/9808acdce2f86e15eaf61e5bc1722392.png">

既読の通知は灰色に変わります。<br>
<img width="400" alt="いいねしたプロフィールの更新時）の画像4" src="https://i.gyazo.com/e979c283029f3345a311b090c3863cdd.png">

### 今後実装予定
* 好みに合うVTuberのレコメンド機能

## 使用技術
|カテゴリ               |技術   |
|----------------------|------|
|フロントエンド          |jQuery 3.7.0|
|バックエンド            |Ruby 3.2.2、Ruby on Rails 7.1.2|
|データベース            |PostgreSQL 16.1|
|認証                  |sorcery 0.17.0|
|インフラ               |Fly.io、Amazon S3、UptimeRobot|
|その他                 |Bootstrap 5.3.5、jQuery UI 1.14.1、CarrierWave 3.1.2、<br>MiniMagick 5.3.0、ransack 4.3.0、kaminari 1.2.2、<br>google-apis-youtube_v3 0.57.0、rspec-rails 6.1.5、RuboCop 1.79.1|

### 選定理由
学習コストと開発スピードのバランスを考慮し、初学者でも扱いやすく有名な技術を中心に選びました。

#### ・フロントエンド
歴史が古く情報量が多いため、初学者でも取り入れやすい点から利用しました。<br>
本アプリでは限定的な使用に留まっています。

#### ・バックエンド
Rubyはコードの記述が簡潔で、日本語のドキュメントが豊富に揃っているので利用しました。<br>
Ruby on Railsは実務で最もよく使用されるフレームワークで、技術記事やドキュメントも充実しているので、実務を意識した開発経験を積むのに適していると考えました。

#### ・データベース
MySQLとPostgreSQLを比較検討した結果、書き込みに強い点からPostgreSQLを利用しました。<br>
本アプリではDBへの書き込みが頻繁に発生することが予想され、将来的な規模拡大も見込んでの選択です。<br>
また、前職でPostgreSQLを扱った経験があり、さらに知識を深めたいという理由もあります。

#### ・認証
ドキュメントも豊富で扱いやすい点から利用しました。<br>
導入時点ではメンテナンスが行われており、現在も動作確認済みです。

#### ・インフラ
Fly.ioについて、初学者の自分にはインフラは難易度が高いと感じたため、PaaSを利用することにしました。<br>
その中でもFly.ioは、技術記事やドキュメントが豊富で比較的簡単にアプリを稼働できる点が魅力です。<br>
また、Fly.ioのリージョンには国内も含まれており、無料で選択できる点も選択の理由です。<br>
Amazon S3について、AWSは信頼性が高く将来的に拡張や柔軟なカスタマイズがしやすいため利用しました。<br>
UptimeRobotについて、Webアプリの死活監視が簡単に行える点から導入しました。

#### ・その他
Bootstrapは多くのクラスがあり、活用することでコードを見やすく整えられるため利用しました。<br>
jQuery UIは自動補完機能を比較的簡単に実装できるため利用しました。<br>
CarrierWaveとMiniMagickは画像処理ができる代表的なGemで、扱いやすくドキュメントも豊富であるため利用しました。<br>
ransackは検索機能を簡単に実装できる代表的なGemであるため利用しました。<br>
kaminariはページネーションを簡単に対応できる代表的なGemであるため利用しました。<br>
google-apis-youtube_v3は、YouTube Data APIをRubyから簡単かつ安全に利用できるため導入しました。<br>
VTuberのプロフィール情報取得に利用しています。<br>
rspec-railsはRSpecを利用するために導入しました。<br>
RSpecは代表的なテストフレームワークで、ドキュメントも豊富であるため選択しました。<br>
RuboCopはLintを実行するために導入しました。

## 画面遷移図
https://www.figma.com/design/C3glur5TElWMfdBr5OtMs3/%E5%90%84%E7%94%BB%E9%9D%A2%E3%81%AEUI?node-id=199-2&t=X90iIDG0hAHd0z44-1

ログインの前後で分けて作成しました。<br>
また、双方で主にヘッダー、ボディ、フッターに分けています。

## ER図
![ER図](https://i.gyazo.com/df70f7f39defdab7972d4a31e896ba55.png)

ユーザーとVTuberに関するテーブルで構成されています。<br>

「vtuber_users」というテーブルがあります。<br>
これは1つのプロフィールについて、その内容に誤りや更新があった際に作成者以外でも誰でも更新できるようにするためのもので、誰がどのプロフィールを更新したかわかるようにしています。<br>
また、vtuber_youtubesというテーブルがあります。<br>
これはプロフィール項目として配信サイトにYouTubeを選択されている方について、チャンネル登録者数をはじめとするチャンネルの情報を格納するためのものです。<br>
さらに、プロフィール項目に関する中間テーブルを各項目分だけ用意しました。<br>
例えば配信サイトはplacesテーブルにあらかじめ私でYouTubeやTwitchといった固有のデータを登録しておきます。<br>
そして、プロフィール設定時に、vtuber_placesテーブルにその配信サイトのidを格納する形にしました。

## こだわった実装
* プロフィール設定時のモーダルにおけるお名前の自動補完
* YouTubeのチャンネル情報の取得

### ・プロフィール設定時のモーダルにおけるお名前の自動補完
これにより、同じ方のプロフィールが重複して作成される可能性を軽減することができます。<br>
また、設定する方も安心して楽に設定画面へ移動することができます。<br>
<img width="400" alt="プロフィール設定時のモーダルにおけるお名前の自動補完の画像1の画像3" src="https://i.gyazo.com/0c0de057ec81c47e1b52fad94b093287.png"><br>

実際のコードは下記の通りです。<br>
まず、jQuery UIを使用してどこかページを読み込んだ瞬間にJavaScriptコードを有効にします。<br>
id="name-setting"はclass="modal-body"のdivタグの中に用意したフォームのtext_fieldで指定しています。<br>

```
$(document).on("turbolinks:load", function () {
  $("#name-setting").autocomplete({
    source: "/vtubers/autocomplete_names",
    minLength: 1
  });
});
```

ヘッダーにある設定ボタンを押し、VTuberのお名前を入力します。<br>
その結果、/vtubers/autocomplete_namesへ入力したお名前が渡されます。<br>
Vtuberコントローラ-のautocomplete_namesアクションが実行されます。<br>

```
def autocomplete_names
  normalized_term = params[:term]
    .then { |t| Moji.zen_to_han(t, Moji::ALNUM) }
    .then { |t| Moji.kata_to_hira(t) }
    .then { |t| Moji.upcase(t) }

  names = Vtuber.pluck(:name).select do |name|
    normalized_name = name
      .then { |n| Moji.zen_to_han(n, Moji::ALNUM) }
      .then { |n| Moji.kata_to_hira(n) }
      .then { |n| Moji.upcase(n) }
    normalized_name.include?(normalized_term)
  end

  render json: names
end
```
この処理では、半角全角/ひらがなカタカナ/大文字小文字を区別しないで候補が表示されるようにしています。<br>
処理内容としては、まず入力したお名前を下記のように正規化します。<br>
正規化はMojiというGemを導入して行なっています。<br>
　　ＶＴｕｂｅｒ　　 →　VTuber<br>
　　ブイチューバー　→　ぶいちゅーばー<br>
　　VTuber　　　　　→　VTUBER<br>
例えばparams[:term]に「AＢc１23」が入っていた場合、まず「zen_to_han」で"Ｂ"と"１"が半角に変わります。<br>
次に「kata_to_hira」は英数字では無関係なので処理されません。<br>
最後に「upcase」で"c"が大文字に変わり、normalized_termには「ABC123」が入ります。<br>
次にDBからプロフィール作成済みのnameを全て取得し、1件ずつ同じルールで正規化します。<br>
そして正規化済みのお名前と正規化済みの1データを確認し、お名前の文字列がデータの文字列に順不同で全部含まれていれば変数（配列）に格納していきます。<br>
1文字からにしているのは、お名前が1文字のVTuberさんもいるためです。<br>
最後にその配列をJSON形式に変換して、autocomplete機能に渡して候補が表示されるようになります。<br>
以上がプロフィール設定時のモーダルにおけるお名前の自動補完です。

### ・YouTubeのチャンネル情報の取得
プロフィール項目に配信サイトがありますが、そこでYouTubeを選択した場合はYouTubeのAPIを使用して、その方のチャンネル情報を取得するようにしています。<br>
必要なのはプロフィール設定時に併せて設定する配信チャンネルのURLと、そこから得られるチャンネルIDです。<br>
<img width="400" alt="YouTubeのチャンネル情報の取得の画像1" src="https://i.gyazo.com/c7476bc9a24a58160355a47f95664653.png">

実際のコード（作成時）は下記の通りです。<br>
プロフィール設定は作成/編集の2パターンがありますが、処理内容は大差ないです。<br>
まず、プロフィール項目の設定を終えて登録ボタンを押して、Vtuberコントローラーのcreateアクションが実行されます。<br>

```
def create
  @vtuber = current_user.vtubers.new(vtuber_params)

  @youtube_channel_id = is_platform_youtube

  if @vtuber.save
    他処理

    if @youtube_channel_id.present?
      youtube_channel_id_check = VtuberYoutube.find_by(channel_id: @youtube_channel_id)
      @vtuber.save_youtube_information(@vtuber.id, @youtube_channel_id) if youtube_channel_id_check.nil?

      @vtuber.get_profile_icon_from_youtube(@vtuber, @youtube_channel_id) if @vtuber.image.identifier.nil?
    end

    リダイレクト
  else
    差し戻し
  end
end
```

まずis_platform_youtubeという下記プライベートメソッドを実行します。<br>
処理内容としては、設定時に設定された配信サイトがYouTubeの場合にそのチャンネルURLからチャンネルIDを取得するというものです。

```
private

def is_platform_youtube
  place_id = params[:vtuber][:vtuber_places_attributes]["0"][:place_id]
  url = params[:vtuber][:vtuber_places_attributes]["0"][:url]
  @vtuber.get_youtube_channel_id(url) if place_id == "1" && url.present?
end
```
実際には処理内でチャンネルURLを引数に、下記インスタンスメソッドget_youtube_channel_idを呼び出しています。<br>
このメソッドはVtuberモデルに書いています。

```
def get_youtube_channel_id(url)
  youtube = youtube_data_api
  begin
    if url.include?("@")
      youtube_handle = url[(url.index("@") + 1)..]
      if youtube_handle.include?("?")
        youtube_handle = youtube_handle[0...youtube_handle.index("?")]
      elsif youtube_handle.include?("/")
        youtube_handle = youtube_handle[0...youtube_handle.index("/")]
      end

      youtube_handle_to_id = youtube.list_channels("statistics", for_handle: youtube_handle).to_h
      return if youtube_handle_to_id[:items].blank?

      youtube_channel_id = youtube_handle_to_id[:items][0][:id]
    elsif url.include?("/UC")
      youtube_channel_id = url[(url.index("/UC") + 1)..]
      youtube_channel_id_digits = 24
      return if youtube_channel_id.length != youtube_channel_id_digits
    else
      return
    end

    youtube_channel_id
  rescue Google::Apis::Error, StandardError
    nil
  end
end
```
初めに同モデル内にある下記youtube_data_apiメソッドを呼び出しています。<br>
ここでYouTube Data APIを使用するためのインスタンスを生成しています。

```
private

def youtube_data_api
  require 'google/apis/youtube_v3'
  youtube = Google::Apis::YoutubeV3::YouTubeService.new
  youtube.key = ENV.fetch('GOOGLE_API_KEY', nil)
  youtube
end
```

次にget_youtube_channel_idメソッドに戻り、受け取ったURLの種類によりID取得のための処理を分岐させています。<br>
具体的にはURLに@が含まれている場合と文字列UCが含まれている場合とそれ以外の3つです。<br>
YouTubeのチャンネルURLは種類があることを知りました。<br>
複数ありますが、その中でも現在よく使われているものは下記3パターンであると定めました。<br>
　　https://www.youtube.com/@ハンドル<br>
　　https://youtube.com/@小文字化したハンドル?si=クエリ<br>
　　https://www.youtube.com/channel/UCから始まるチャンネルID<br>
プロフィール設定時において、URLの種類に制限は設けておらず、それぞれのパターンに対応できるようにしています。<br>
まず@が含まれているパターンについて、@より後の部分（ハンドル）を抽出します。<br>
　　https://www.youtube.com/@ハンドル　→　ハンドル<br>
意図としては、後続処理でAPIを使用してハンドルからIDを求めるためです。<br>
ハンドルを含んだURLに関しては、IDを求めなくてもハンドルを指定することで直接チャンネル情報を取得することも一部可能なのですが、欲しい情報全部ではないので便宜上IDを求める処理を挟むことにいたしました。<br>
抽出した部分の内容により、さらに分岐をさせています。<br>
理由はURLのパターン2つ目や下記のように、ハンドルの後に文字が続くURLに対応するためです。<br>
　　https://www.youtube.com/@ハンドル/videos<br>
それぞれ指定の文字を条件に抽出します。<br>
　　小文字化したハンドル?si=クエリ　→　小文字化したハンドル<br>
　　ハンドル/videos　　　　　　　　→　ハンドル<br>
取得したハンドルを引数に、APIのlist_channelsメソッドを実行します。<br>
直後に条件付きでreturnをしていますが、これは取得したハンドルが無効つまり設定されたURLが誤りで情報が取得できなかった場合に通ります。<br>
その場合、IDは取得されることなくcreateアクションに戻ります。<br>
正しくメソッドが実行できた場合は、そこからチャンネルIDを取得し、@が含まれていた場合の処理は終了です。<br>
次に文字列UCが含まれていた場合は、UC以降を抽出します。<br>
　　https://www.youtube.com/channel/UCから始まるチャンネルID　→　UCから始まるチャンネルID<br>
YouTubeのチャンネルIDは24文字固定のため、抽出した文字列の桁数が24文字ではない場合は同じくreturnを通ります。<br>
それ以外のURLは扱っていないためreturnです。<br>
戻り値はチャンネルIDです。<br>
以上がget_youtube_channel_idメソッドおよびis_platform_youtubeメソッドです。<br><br>
createアクションに戻り@vtuberの保存に成功した場合、続けてチャンネル情報も保存してく流れです。<br>
次にIDが取得できた場合、作成時ではそのIDがチャネル情報を扱うvtuber_youtubesテーブルにまだ登録されていないことを確認します。<br>
重複していないことを確認できたら、登録したVTuberのidとチャンネルIDを引数に、同モデルに書いた下記インスタンスメソッドsave_youtube_informationを呼び出します。<br>

```
def save_youtube_information(vtuber_id, youtube_channel_id)
  youtube = youtube_data_api
  begin
    youtube_channel = youtube.list_channels("statistics", id: youtube_channel_id).to_h
    return if youtube_channel[:items].blank?

    subscriber_count = youtube_channel[:items][0][:statistics][:subscriber_count]
    video_count = youtube_channel[:items][0][:statistics][:video_count]

    youtube_video = youtube.list_searches("snippet", channel_id: youtube_channel_id, type: 'video', max_results: 1, order: :date).to_h
    if youtube_video[:items]&.any?
      latest_video_id = youtube_video[:items][0][:id][:video_id]
      latest_video_title = youtube_video[:items][0][:snippet][:title]
    else
      latest_video_id = nil
      latest_video_title = nil
    end

    record = VtuberYoutube.find_or_initialize_by(vtuber_id: vtuber_id)
    record.update!(
      channel_id: youtube_channel_id,
      subscriber_count: subscriber_count,
      video_count: video_count,
      latest_video_id: latest_video_id,
      latest_video_title: latest_video_title
    )
  rescue Google::Apis::Error, StandardError
    nil
  end
end
```

処理内容としては、IDを基にチャンネル情報を取得してDBに格納するというものです。<br>
初めに同様にAPI使用のためのインスタンスを生成します。<br>
次にAPIのlist_channelsメソッドを実行し、チャンネル登録者数とこれまでの投稿動画数を取得します。<br>
直後に条件付きでreturnをしていますが、これは取得したIDが無効であった場合に通ります。<br>
可能性は限りなく低いと思われますが、ケースとしては設定されたURLが24文字のIDを含んだタイプだが適当なものであった場合に該当し、ここで弾かれます。<br>
次にAPIのlist_searchesメソッドを実行し、最新動画のidと動画タイトルを取得します。<br>
こちらのメソッドで結果がnilの場合はreturnではなくそのままにしています。<br>
理由は前半のメソッドとこのメソッドとではnilの理由が異なるからです。<br>
前半のメソッドは存在しないIDによるもので、このメソッドはまだ動画が1つもない場合にnilを返します。<br>
取得した情報たちを格納してsave_youtube_informationメソッドは終了です。<br><br>
createアクションに戻りプロフィール画像が設定されているかを確認します。<br>
設定されていない場合、チャンネルのアイコンを使用するようにしています。<br>
<img width="400" alt="YouTubeのチャンネル情報の取得の画像2" src="https://i.gyazo.com/e19448b8a97aaf10672ea4d4c4afa48f.png">

登録したVTuberのインスタンスとチャンネルIDを引数に、同モデルに書いた下記インスタンスメソッドget_profile_icon_from_youtubeを呼び出します。<br>

```
def get_profile_icon_from_youtube(vtuber, youtube_channel_id)
  youtube_channel = youtube_data_api.list_channels("snippet", id: youtube_channel_id).to_h
  vtuber.remote_image_url = youtube_channel[:items][0][:snippet][:thumbnails][:high][:url]
  vtuber.save
  vtuber.reload
end
```

処理内容としては、IDを基にチャンネルアイコンを取得して保存するというものです。<br>
初めに同様にAPIのインスタンスを生成し、APIのlist_channelsメソッドを実行します。<br>
取得結果からチャンネルのアイコン画像のURLを取得し、画像ファイルとして保存します。<br>
IDが無効の場合はNULLが入りますが、その場合はデフォルト画像がアイコンになるようにしています。<br>
以上がget_profile_icon_from_youtubeメソッドです。<br><br>
以上がプロフィール設定時のYouTube周りの処理です。<br>
さらに、チャンネルの情報は日々変わるため、定期的に情報を取得してデータを更新するようにしています。<br>
実際のコードは下記の通りです。<br>

```
namespace :vtuber_youtube do
  desc "VTuberのYouTube統計情報を定期的に更新"
  task update: :environment do
    require 'google/apis/youtube_v3'
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV.fetch('GOOGLE_API_KEY', nil)

    VtuberYoutube.pluck(:channel_id).each do |channel_id|
      sleep 1
      begin
        record = VtuberYoutube.find_by(channel_id: channel_id)
        next unless record

        youtube_channel = youtube.list_channels("statistics", id: channel_id).to_h
        next if youtube_channel[:items].blank?

        subscriber_count = youtube_channel[:items][0][:statistics][:subscriber_count]
        video_count = youtube_channel[:items][0][:statistics][:video_count]

        youtube_video = youtube.list_searches("snippet", channel_id: channel_id, type: 'video', max_results: 1, order: :date).to_h
        if youtube_video[:items]&.any?
          latest_video_id = youtube_video[:items][0][:id][:video_id]
          latest_video_title = youtube_video[:items][0][:snippet][:title]
        else
          latest_video_id = nil
          latest_video_title = nil
        end

        record.update!(
          subscriber_count: subscriber_count,
          video_count: video_count,
          latest_video_id: latest_video_id,
          latest_video_title: latest_video_title
        )
      rescue Google::Apis::Error, StandardError
        puts "エラー"
        next
      end
    end

    puts "[完了]VTuberのYouTube統計情報を定期的に更新"
  end
end
```

処理内容はインスタンスメソッドsave_youtube_informationと大差ないです。<br>
vtuber_youtubesテーブルにチャンネルIDも格納しているので、この定期処理ではそれを利用して1件ずつ更新しています。<br>
crontab、Dockerfile、fly.tomlも編集し、毎日午前3:00に実行するようにしています。<br>
以上がYouTubeのチャンネル情報の取得です。<br>