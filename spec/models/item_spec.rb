require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品が出品できる場合' do
      it 'nameとdescriptionとcategory_idとstatus_idとprefecture_idとfee_status_idとdays_to_ship_idとselling_priceとimageがあれば出品できる' do
        expect(@item).to be_valid
      end
      it 'selling_priceが300以上、9,999,999以下の半角数字であれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'category_idが空では出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it 'category_idの値が1では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'status_idが空では出品できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it 'status_idの値が1では出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'prefecture_idが空では出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'prefecture_idの値が1では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'fee_status_idが空では登録できない' do
        @item.fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it 'fee_status_idの値が1では出品できない' do
        @item.fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'days_to_ship_idが空では出品できない' do
        @item.days_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it 'days_to_ship_idの値が1では出品できない' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'selling_priceが空では出品できない' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'selling_priceが300より小さい場合は出品できない' do
        @item.selling_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300以上の値にしてください')
      end
      it 'selling_priceが9,999,999より小さい場合は出品できない' do
        @item.selling_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は9999999以下の値にしてください')
      end
      it 'selling_priceが全角数字の場合は出品できない' do
        @item.selling_price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it 'selling_priceが半角英数字混合の場合は出品できない' do
        @item.selling_price = '1000o'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it 'selling_priceが半角英字の場合は出品できない' do
        @item.selling_price = 'ioooo'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
    end
  end
end
