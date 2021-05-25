class Shipping < ApplicationRecord
  # orderモデルとのアソシエーション
  belongs_to :order
end
