# smoking-area-map-app 🚬

位置情報を活用して喫煙所を検索・登録できるアプリケーション

## 🛠 使用技術

- フロントエンド：React (TypeScript)
- バックエンド：Ruby on Rails (APIモード)
- データベース：PostgreSQL
- その他：GitHub

## ✅ 実装済み機能

- [ ] 喫煙所の一覧表示・投稿・編集・削除
- [ ] コメント投稿
- [ ] 現在地から近い喫煙所検索
- [ ] 喫煙所を絞り込み検索
- [ ] ログイン・ログアウト（JWT認証）

## API仕様
- 詳細な仕様・設計 : Notion https://www.notion.so/API-279f0859fd2d8031b817c8b23903b841?source=copy_link
- OpenAPI (v0.1 下書き) : `docs/openapi.yaml`

## 🔧 ローカル環境での立ち上げ方法

### Rails API（バックエンド）
```bash
cd smoking_area_map_api
bundle install
rails db:create db:migrate
rails s
