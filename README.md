# chat-space0

メッセージを送信するアプリケーション

## 機能
- 新規登録機能
- グループ内でのチャット機能
- 複数人によるグループチャット機能
- チャット相手の検索機能
- チャットグループへのユーザー招待機能
- チャットの履歴表示機能
- 画像送信機能
- チャットの自動更新

## 追加機能・要素
未定

## 特記事項
- サーバーサイド側を主に復習する為、フロント側は前回作成時のものを引用する（予定）
- その他、未定


#Structure of DataBase

## membersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|group_id|references|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user


## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|body|text|-|
|image|string|-|
|group_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|name|string|unique: true, index: true|
|email|string|unique: true|
|password|string|null: false|

### Association
- has_many :groups, through: :members
- has_many :messages
- has_many :members


## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|group_name|string|null: false|

### Association
- has_many :users, through: :members
- has_many :messages
- has_many :members
