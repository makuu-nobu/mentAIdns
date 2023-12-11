# アプリケーション名
mentAIdns

# README
OpenAIを使用した性格診断アプリ

# ツール・ライブラリ
* Rails 7.0.0
* DB : mySQL
* Ruby 3.2.0

# デプロイ
現在まだデプロイが完了していません。完了次第更新します。

# どんなアプリ？
Ruby on RailsでOpenAIを利用した性格診断アプリです。
５つの質問に答えるとAIが選択に沿って回答をしてくれます。

# 使い方
* 1.まずは新規登録からユーザー登録を行います。（emailは@が必要で す。他は適当でも大丈夫です）
* 2.診断へ進みます
* 3.「質問に答える」を押すと選択肢が現れるので選択します。（たまにJavaScriptの挙動がうまくいかない場合があります。その場合他の選択肢をクリックしてみてください）
* 4.5問答えると結果が表示されます。（ロードが少し長いのでお待ちください）
* 5.ユーザー詳細画面からは回答の公開設定と、回答結果の消去ができます。
* 6.「みんなの回答」からは他のユーザーの回答結果を閲覧できます。

# 注意点
* １ユーザーにつき回答結果は一つです。もし再度診断を受けたい場合は自身の回答結果を削除してから行なってください。
* この診断は科学的根拠や専門家の意見などもなく作成しています。そのため必ずしも正しいとは言えません
* まれに同じ質問が繰り返されることもありますが、バグではなく仕様です。今後修正する予定です。
* 他、テストが不十分な部分もあり予期せぬエラーが発生する可能性もあります。

# アプリを作成の動機
* よくある性格診断には選択肢を回答するまでの時間経過を測定せずに、評価値で判断しているため、回答時間を加味した柔軟な問題生成を行えるアプリを作成してみようと思いました。

* 自身には性格診断のためのプロセスや心理学的アプローチについての知識がないため、AIを利用して情報を収集することで、完成度を高めていくための要素を収集できると思いました。

* OpenAIのAPIを叩いてみたかったです。

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/c8125a51a4b62df069a38f2977db8be4.png)](https://gyazo.com/c8125a51a4b62df069a38f2977db8be4)

# 制作期間
約２週間ほど

# 工夫した点
* bootstrapを利用してレスポンシブでもある程度対応できるようにした
* OpenAIへのリクエストをgemを利用せずに行いました。（多くの記事でgemを活用していましたが、最近になってOpenAIがJsonファイルでのリクエストでも対応可能になったため、rubyの標準ライブラリで実装しています。）
* 今後改良、追加実装できるようにDB設計から丁寧に作りました（無駄なカラムがあるのはそのため）

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/d3459533cb07df110379b3c9aa12fe80.png)](https://gyazo.com/d3459533cb07df110379b3c9aa12fe80)

## `questions` Table

| Column Name    | Data Type | Constraints    | Description            |
| -------------- | --------- | -------------- | ---------------------- |
| id             | integer   | null:false     | Unique identifier     |
| question_text  | text      | null:false     | Text of the question   |

### Associations
- has_one :answer

## `choices` Table

| Column Name   | Data Type  | Constraints    | Description               |
| ------------- | ---------- | -------------- | ------------------------- |
| id            | integer    | null:false     | Unique identifier        |
| question_id   | references | null:false     | Foreign key to questions |
| result_answer | string     | null:false     | Answer for the question  |
| choice_2      | string     | null:false     | Choice 2 for the question |
| choice_3      | string     | null:false     | Choice 3 for the question |
| choice_4      | string     | null:false     | Choice 4 for the question |
| answer_time   | integer    | null:false     | Time to answer the question |

### Associations
- has_one :answer

## `users` Table

| Column Name        | Data Type  | Constraints    | Description                          |
| ------------------ | ---------- | -------------- | ------------------------------------ |
| id                 | integer    | null:false     | Unique identifier                   |
| username           | string     | null:false     | Username of the user                 |
| release_option     | integer    | null:false     | Release option for the user          |
| email              | string     | null:false     | Email address of the user            |
| encrypted_password | string     | null:false     | Encrypted password of the user       |
| admin              | boolean    | null:false     | Admin status (default: 0)            |

### Associations
- has_many :answers
- has_one :result

## `answers` Table

| Column Name | Data Type  | Constraints    | Description                          |
| ----------- | ---------- | -------------- | ------------------------------------ |
| id          | integer    | null:false     | Unique identifier                   |
| user_id     | references | null:false     | Foreign key to users                 |
| question_id | references | null:false     | Foreign key to questions             |
| choice_id   | references | null:false     | Foreign key to choices               |
| timestamp   | datetime   |                | Timestamp of the answer              |

### Associations
- belongs_to :user
- belongs_to :question
- belongs_to :choice

## `results` Table

| Column Name | Data Type  | Constraints    | Description                          |
| ----------- | ---------- | -------------- | ------------------------------------ |
| result_text | text       | null:false     | Text of the result                   |
| user_id     | references | null:false     | Foreign key to users                 |

### Associations
- belongs_to :user

## その他
* 今後の修正について
現在確認されているエラーは「選択肢表示時にまれに選択できない現象が起きる（おそらくJSの挙動がおかしい）」

* 今後アップデートする際の機能（未実装の機能）
・質問の数を増やすことができるように管理者画面を作成（質問の生成、編集、削除）
・自身の回答結果を保存できるようにする
・１ユーザーが複数の回答を生成できるようにする
・ユーザー名の変更ができるように設定
・質問文と選択肢をAI生成できるようにする