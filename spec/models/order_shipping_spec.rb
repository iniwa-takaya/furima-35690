require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
      sleep(0.05)
    end

    context '商品が購入できる場合' do
      it '全ての情報があれば購入できる' do
        expect(@order_shipping).to be_valid
      end
      it 'buildingがなくても購入できる' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
      it 'postal_codeは、3桁の半角数字、ハイフン(-)、4桁の半角数字であれば購入できる' do
        expect(@order_shipping).to be_valid
      end
      it 'phone_numberは、11桁で半角数字であれば購入できる' do
        expect(@order_shipping).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'postal_codeが空では購入できない' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeに-がない場合は購入できない' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが空では購入できない' do
        @order_shipping.prefecture_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idの値が1では購入できない' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では購入できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'address_nameが空では購入できない' do
        @order_shipping.address_name = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address name can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが11桁より小さければ購入できない' do
        @order_shipping.phone_number = 1_234_567_890
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_numberが全角数字の場合は購入できない' do
        @order_shipping.phone_number = '１２３４５６７８９０１'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが半角英数字混合の場合は購入できない' do
        @order_shipping.phone_number = 'a1234567890'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが半角英字の場合は購入できない' do
        @order_shipping.phone_number = 'abcdefghijk'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'tokenが空では購入できない' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
