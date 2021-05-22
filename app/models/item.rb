class Item < ApplicationRecord
  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :days_to_ship
  belongs_to :prefecture
  belongs_to :ship_from
  belongs_to :status
  # ActiveHashのバリデーション
  with_options numericality; { other_than: 1 } do
    validates :category_id
    validates :days_to_ship_id
    validates :prefecture_id
    validates :ship_from_id
    validates :status_id
  end
  # 他のモデルとのアソシエーション
  belongs_to :user
  has_one_attached :image
end
