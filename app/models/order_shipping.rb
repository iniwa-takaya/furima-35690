class OrderShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address_name, :building, :phone_number, :token

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code,
              format: { with: /\A\d{3}-\d{4}\z/, message: 'が誤っています 例）123-4567' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :address_name
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁、11桁のみです' },
                             numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :token
  end
  # データをテーブルに保存する処理
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Shipping.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id,
                    city: city, address_name: address_name, building: building, phone_number: phone_number)
  end
end
