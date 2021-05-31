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
      it 'phone_numberは、11桁以内で半角数字であれば購入できる' do
        expect(@order_shipping).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'postal_codeが空では購入できない' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeに-がない場合は購入できない' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('郵便番号が誤っています 例）123-4567')
      end
      it 'prefecture_idが空では購入できない' do
        @order_shipping.prefecture_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'prefecture_idの値が1では購入できない' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("都道府県を選択してください")
      end
      it 'cityが空では購入できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'address_nameが空では購入できない' do
        @order_shipping.address_name = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では購入できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが10桁より小さければ購入できない' do
        @order_shipping.phone_number = '123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は10桁、11桁のみです')
      end
      it 'phone_numberが11桁より大きければ購入できない' do
        @order_shipping.phone_number = '123456789012'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は10桁、11桁のみです')
      end
      it 'phone_numberが全角数字の場合は購入できない' do
        @order_shipping.phone_number = '１２３４５６７８９０１'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は半角数字で入力してください')
      end
      it 'phone_numberが半角英数字混合の場合は購入できない' do
        @order_shipping.phone_number = 'a1234567890'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は半角数字で入力してください')
      end
      it 'phone_numberが半角英字の場合は購入できない' do
        @order_shipping.phone_number = 'abcdefghijk'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は半角数字で入力してください')
      end
      it 'tokenが空では購入できない' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'user_idが存在しない場合購入できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが存在しない場合購入できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
