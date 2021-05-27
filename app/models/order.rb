class Order < ApplicationRecord
  #  他のモデルとのアソシエーション
  belongs_to :item
  belongs_to :user
  has_one :shipping
end
