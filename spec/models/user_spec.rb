require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'email、passwordとpassword-confirmationとnick_nameとlast_nameとfirst_nameとlast_name_kanaとfirst_name_kanaとbirthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが一致しており、6文字以上で、半角英数字混合であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
      it 'last_nameとfirst_nameは全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.last_name = '亞アあ'
        @user.first_name = '亞アあ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaとfirst_name_kanaは全角（カタカナ）であれば登録できる' do
        @user.last_name_kana = 'ア'
        @user.first_name_kana = 'ア'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '@がなければemailは登録できない' do
        @user.email = 'abc.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordは、数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordは、半角英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordは、全角では登録できない' do
        @user.password = 'ａ１２３４５'
        @user.password_confirmation = 'ａ１２３４５'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = 'a123456'
        @user.password_confirmation = 'a1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'nick_nameが空では登録できない' do
        @user.nick_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)を入力してください")
      end
      it 'last_name全角（漢字・ひらがな・カタカナ）以外の文字が存在すると登録できない' do
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角)は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)を入力してください")
      end
      it 'first_nameに全角（漢字・ひらがな・カタカナ）以外の文字が存在すると登録できない' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角)は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角)を入力してください")
      end
      it 'last_name_kanaは全角（カタカナ）以外の文字（英語）が存在すると登録できない' do
        @user.last_name_kana = 'aａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)は全角（カタカナ）で入力してください')
      end
      it 'last_name_kanaは全角（カタカナ）以外の文字（全角文字）が存在すると登録できない' do
        @user.last_name_kana = 'あ亞'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)は全角（カタカナ）で入力してください')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角)を入力してください")
      end
      it 'first_name_kanaは全角（カタカナ）以外の文字（英語）が存在すると登録できない' do
        @user.first_name_kana = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)は全角（カタカナ）で入力してください')
      end
      it 'first_name_kanaは全角（カタカナ）以外の文字（全角文字）が存在すると登録できない' do
        @user.first_name_kana = 'あ亞'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角)は全角（カタカナ）で入力してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
