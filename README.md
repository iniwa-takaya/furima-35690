# テーブル設計

## users テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| email          | string | null: false |
| password       | string | null: false |
| nick_name      | string | null: false |
| last_name      | string | null: false |
| first_name     | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana| string | null: false |
| birthday       | date   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column         | Type      | Options     |
| -------------- | --------- | ----------- |
| item_name      | string    | null: false |
| description    | text      | null: false |
| category_id    | integer   | null: false |
| status_id      | integer   | null: false |
| prefecture_id  | integer   | null: false |
| ship_from_id   | integer   | null: false |
| days_to_ship_id| integer   | null: false |
| selling_price  | integer   | null: false |
| user_id        | references|             |

### Association

- has_many :orders
- belongs_to :user

## orders テーブル

| Column         | Type      | Options     |
| -------------- | --------- | ----------- |
| user_id        | references|             |
| item_id        | references|             |

### Association

- belongs_to :items
- belongs_to :user
- has_one :shipping

## shippings テーブル

| Column        | Type      | Options     |
| ------------- | --------- | ----------- |
| order_id      | references|             |
| postal_code   | sting     | null: false |
| prefecture_id | integer   | null: false |
| city          | string    | null: false |
| address_name  | string    | null: false |
| building      | string    |             |
| phone_number  | string    | null: false |

### Association

- belongs_to :order
