require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { build(:user) }

    it '有効な属性値' do
      expect(user).to be_valid
    end

    context 'メールアドレス' do
      subject { user.errors[:email] }

      it '入力している' do
        user.email = ""
        user.valid?
        expect(subject).to include "を入力してください"
      end

      it '重複していない' do
        create(:user, email: "test@com")
        user.email = "test@com"
        user.valid?
        expect(subject).to include "はすでに存在します"
      end
    end

    context 'パスワード' do
      subject { user.errors[:password] }

      it '入力されている' do
        user.password = ""
        user.valid?
        expect(subject).to include "を入力してください"
      end

      it '文字数が規定以上' do
        user.password = "test1"
        user.valid?
        expect(subject).to include "は8文字以上で入力してください"
      end
    end

    context 'パスワード確認' do
      subject { user.errors[:password_confirmation] }

      it '入力されている' do
        user.password_confirmation = ""
        user.valid?
        expect(subject).to include "とパスワードの入力が一致しません"
      end

      it '一致する' do
        user.password_confirmation = user.password + "test"
        user.valid?
        expect(subject).to include "とパスワードの入力が一致しません"
      end
    end

    context 'パスワードリセット' do
      subject { user.errors[:reset_password_token] }

      it 'トークンが重複していない' do
        create(:user, reset_password_token: "test")
        user.reset_password_token = "test"
        user.valid?
        expect(subject).to include "はすでに存在します"
      end

      it 'トークンがnilなら重複は問わない' do
        create(:user)
        expect(user).to be_valid
      end
    end

    context 'ユーザー名' do
      subject { user.errors[:name] }

      it '入力されている' do
        user.name = ""
        user.valid?
        expect(subject).to include "を入力してください"
      end
    end

    context '利用規約とプライバシーポリシー' do
      subject { user.errors[:agreement] }

      it '同意している' do
        user.agreement = "0"
        user.valid?
        expect(subject).to include "に同意してください"
      end
    end
  end

  describe 'association' do
    let(:user) { create(:user) }
    let(:vtuber) { create(:vtuber) }

    context 'vtuber_users/vtubers' do
      it 'vtuber_users/vtubers' do
        create(:vtuber_user, user: user, vtuber: vtuber)
        expect(user.vtubers.count).to eq 1
      end

      it 'dependent: :destroy' do
        create(:vtuber_user, user: user, vtuber: vtuber)
        expect { user.destroy }.to change { VtuberUser.count }.by(-1)
      end
    end

    context 'favorites/favorite_vtubers' do
      it 'favorites/favorite_vtubers' do
        create(:favorite, user: user, vtuber: vtuber)
        expect(user.favorite_vtubers.count).to eq 1
      end

      it 'dependent: :destroy' do
        create(:favorite, user: user, vtuber: vtuber)
        expect { user.destroy }.to change { Favorite.count }.by(-1)
      end
    end

    context 'comments/vtubers' do
      it 'comments/vtubers' do
        create(:comment, user: user, vtuber: vtuber)
        expect(user.vtubers.count).to eq 1
      end

      it 'dependent: :destroy' do
        create(:comment, user: user, vtuber: vtuber)
        expect { user.destroy }.to change { Comment.count }.by(-1)
      end
    end

    context 'active_notifications' do
      it 'active_notifications' do
        create(:favorite, user: create(:user), vtuber: vtuber)
        visited_id = Favorite.find_by(vtuber_id: vtuber.id)&.user_id
        visited_user = User.find(visited_id)
        create(:notification, visitor: user, visited: visited_user, vtuber: vtuber)
        expect(user.active_notifications.count).to eq 1
      end

      it 'dependent: :destroy' do
        create(:favorite, user: create(:user), vtuber: vtuber)
        visited_id = Favorite.find_by(vtuber_id: vtuber.id)&.user_id
        visited_user = User.find(visited_id)
        create(:notification, visitor: user, visited: visited_user, vtuber: vtuber)
        expect { user.destroy }.to change { Notification.count }.by(-1)
      end
    end

    context 'passive_notifications' do
      it 'passive_notifications' do
        create(:notification, visitor: create(:user), visited: user, vtuber: vtuber)
        expect(user.passive_notifications.count).to eq 1
      end

      it 'dependent: :destroy' do
        create(:notification, visitor: create(:user), visited: user, vtuber: vtuber)
        expect { user.destroy }.to change { Notification.count }.by(-1)
      end
    end
  end
end
