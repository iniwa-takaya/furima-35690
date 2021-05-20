# テーブル設計

## users テーブル

| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| email             | string | null: false, unique:true |
| encrypted_password| string | null: false |
| nick_name         | string | null: false |
| last_name         | string | null: false |
| first_name        | string | null: false |
| last_name_kana    | string | null: false |
| first_name_kana   | string | null: false |
| birthday          | date   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column         | Type      | Options     |
| -------------- | --------- | ----------- |
| name           | string    | null: false |
| description    | text      | null: false |
| category_id    | integer   | null: false |
| status_id      | integer   | null: false |
| prefecture_id  | integer   | null: false |
| ship_from_id   | integer   | null: false |
| days_to_ship_id| integer   | null: false |
| selling_price  | integer   | null: false |
| user           | references| foreign_key: true|

### Association

- has_one :order
- belongs_to :user

## orders テーブル

| Column      | Type      | Options          |
| ----------- | --------- | ---------------- |
| user        | references| foreign_key: true|
| item        | references| foreign_key: true|

### Association

- belongs_to :item
- belongs_to :user
- has_one :shipping

## shippings テーブル

| Column        | Type      | Options     |
| ------------- | --------- | ----------- |
| order         | references| foreign_key: true|
| postal_code   | string    | null: false |
| prefecture_id | integer   | null: false |
| city          | string    | null: false |
| address_name  | string    | null: false |
| building      | string    |             |
| phone_number  | string    | null: false |

### Association

- belongs_to :order
