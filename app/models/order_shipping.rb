class OrderShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :order_id, :postal_code, :prefecture_id, :city, :address_name, :building, :phone_number
  
  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :order_id
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1 } 
    validates :city
    validates :address_name
    validates :building
    validates :phone_number, format: { with: /\A\d{11}\z/, message: "is invalid. 11 digits or less" }
  end

  def save
    order = Order.create(user_id: user_id, order_id: order_id)
    Shipping.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id,
                    city: city, address_name: address_name, building: building, phone_number: phone_number)
  end
end