class Item < ApplicationRecord
  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :days_to_ship
  belongs_to :prefecture
  belongs_to :fee_status
  belongs_to :status

  # 他のモデルとのアソシエーション
  belongs_to :user
  has_one :order
  has_one_attached :image

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    with_options numericality: { other_than: 1, message: "を選択してください" } do
      validates :category_id
      validates :days_to_ship_id
      validates :prefecture_id
      validates :fee_status_id
      validates :status_id
    end
    validates :selling_price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                              format: { with: /\A[0-9]+\z/ }
  end
end
