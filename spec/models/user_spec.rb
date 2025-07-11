require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {build(:user)}

  describe 'validation' do
    it '有効な属性値' do
      expect(user).to be_valid
    end

    context 'メールアドレス' do
      subject {user.errors[:email]}
      it '入力している' do
        user.email = ""
        user.valid?
        is_expected.to include "を入力してください"
      end
      it '重複していない' do
        create(:user, email: "test@com")
        user.email = "test@com"
        user.valid?
        is_expected.to include "はすでに存在します"
      end
    end

    context 'パスワード' do
      subject {user.errors[:password]}
      it '入力されている' do
        user.password = ""
        user.valid?
        is_expected.to include "を入力してください"
      end
      it '文字数が規定以上' do
        user.password = "test1"
        user.valid?
        is_expected.to include "は8文字以上で入力してください"
      end
    end

    context 'パスワード確認' do
      subject {user.errors[:password_confirmation]}
      it '入力されている' do
        user.password_confirmation = ""
        user.valid?
        is_expected.to include "とパスワードの入力が一致しません"
      end
      it '一致する' do
        user.password_confirmation = user.password + "test"
        user.valid?
        is_expected.to include "とパスワードの入力が一致しません"
      end
    end

    context 'パスワードリセット' do
      subject {user.errors[:reset_password_token]}
      it 'トークンが重複していない' do
        create(:user, reset_password_token: "test")
        user.reset_password_token = "test"
        user.valid?
        is_expected.to include "はすでに存在します"
      end
      it 'トークンがnilなら重複は問わない' do
        create(:user)
        expect(user).to be_valid
      end
    end

    context 'ユーザー名' do
      subject {user.errors[:name]}
      it '入力されている' do
        user.name = ""
        user.valid?
        is_expected.to include "を入力してください"
      end
    end

    context '利用規約とプライバシーポリシー' do
      subject {user.errors[:agreement]}
      it '同意している' do
        user.agreement = "0"
        user.valid?
        is_expected.to include "に同意してください"
      end
    end
  end
end