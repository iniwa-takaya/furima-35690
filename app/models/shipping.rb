class Shipping < ApplicationRecord
  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  
  # orderモデルとのアソシエーション
  belongs_to :order
end
