require 'rails_helper'

RSpec.describe Vtuber, type: :model do
  describe 'validation' do
    let(:vtuber) {build(:vtuber)}

    it '有効な属性値' do
      expect(vtuber).to be_valid
    end

    context '名前' do
      subject {vtuber.errors[:name]}
      it '入力されている' do
        vtuber.name = ""
        vtuber.valid?
        is_expected.to include "を入力してください"
      end
      it '重複していない' do
        create(:vtuber, name: "test")
        vtuber.name = "test"
        vtuber.valid?
        is_expected.to include "はすでに存在します"
      end
    end

    context 'Xのユーザ名' do
      it '重複していない' do
        create(:vtuber, name_x: "test");
        vtuber.name_x = "test"
        vtuber.valid?
        expect(vtuber.errors[:name_x]).to include "はすでに存在します"
      end
      it 'nilなら重複は問わない' do
        create(:vtuber, name_x: nil)
        vtuber.name_x = nil
        expect(vtuber).to be_valid
      end
      it '空白なら重複は問わない' do
        create(:vtuber, name_x: "")
        vtuber.name_x = ""
        expect(vtuber).to be_valid
      end
    end
  end

  describe 'assocication' do
    let(:user) {create(:user)}
    let(:vtuber) {create(:vtuber)}
    
    context 'vtuber_users/users' do
      it 'vtuber_users/users' do
        create(:vtuber_user, user: user, vtuber: vtuber)
        expect(vtuber.users.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:vtuber_user, user: user, vtuber: vtuber)
        expect {vtuber.destroy}.to change {VtuberUser.count}.by(-1)
      end
    end
    
    context 'vtuber_places/places' do
      let(:place) {create(:place)}
      it 'vtuber_places/places' do
        create(:vtuber_place, vtuber: vtuber, place: place)
        expect(vtuber.places.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:vtuber_place, vtuber: vtuber, place: place)
        expect {vtuber.destroy}.to change {VtuberPlace.count}.by(-1)
      end
    end

    context 'vtuber_contents/contents' do
      let(:content) {create(:content)}
      it 'vtuber_contents/contents' do
        create(:vtuber_content, vtuber: vtuber, content: content)
        expect(vtuber.contents.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:vtuber_content, vtuber: vtuber, content: content)
        expect {vtuber.destroy}.to change {VtuberContent.count}.by(-1)
      end
    end

    context 'favorites/favorite_users' do
      it 'favorites/favorite_users' do
        create(:favorite, user: user, vtuber: vtuber)
        expect(vtuber.favorite_users.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:favorite, user: user, vtuber: vtuber)
        expect {vtuber.destroy}.to change {Favorite.count}.by(-1)
      end
    end

    context 'vtuber_tags/tags' do
      let(:tag) {create(:tag)}
      it 'vtuber_tags/tags' do
        create(:vtuber_tag, vtuber: vtuber, tag: tag)
        expect(vtuber.tags.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:vtuber_tag, vtuber: vtuber, tag: tag)
        expect {vtuber.destroy}.to change {VtuberTag.count}.by(-1)
      end
    end

    context 'comments' do
      it 'comments' do
        create(:comment, user: user, vtuber: vtuber)
        expect(vtuber.comments.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:comment, user: user, vtuber: vtuber)
        expect {vtuber.destroy}.to change {Comment.count}.by(-1)
      end
    end

    context 'notifications' do
      it 'notifications' do
        create(:favorite, user: create(:user), vtuber: vtuber)
        visited_id = Favorite.find_by(vtuber_id: vtuber.id)&.user_id
        visited_user = User.find(visited_id)
        create(:notification, visitor: create(:user), visited: visited_user, vtuber: vtuber)
        expect(vtuber.notifications.count).to eq 1
      end
    end
  end

  describe 'save_tags(tags)' do
    let(:vtuber) {create(:vtuber)}

    context '配列要素が新規のみ' do
      it 'VtuberTag、Tagに新規追加される' do
        vtuber.save_tags(["あ", "い", "う"])
        expect(vtuber.tags.pluck(:name)).to match_array(["あ", "い", "う"])
        expect(Tag.count).to eq 3
      end
    end

    context '配列要素が新規と既存' do
      before do
        vtuber.save_tags(["あ", "い", "う"])
      end
      it 'VtuberTagは新規追加、既存維持、旧式削除、Tagは新規追加される' do
        vtuber.save_tags(["う", "え", "お"])
        expect(vtuber.tags.pluck(:name)).to match_array(["う", "え", "お"])
        expect(Tag.where(name: ["あ","い"]).count).to eq 2
        expect(Tag.count).to eq 5
      end
    end

    context '配列要素が空（登録タグが無い）' do
      before do
        vtuber.save_tags(["あ", "い", "う"])
      end
      it 'VtuberTagは旧式削除、Tagは維持される' do
        vtuber.save_tags([])
        expect(vtuber.tags).to be_empty
        expect(Tag.count).to eq 3
      end
    end

    context '配列要素が重複' do
      it 'VtuberTag、Tagに新規の重複は1件追加' do
        vtuber.save_tags(["あ", "い", "あ"])
        expect(vtuber.tags.pluck(:name)).to match_array(["あ", "い"])
        expect(Tag.count).to eq 2
      end
    end
  end

  describe 'set_notification_update(current_user)' do
    let(:vtuber) {create(:vtuber)}
    let(:current_user) {create(:user)}

    context '通知相手（お気に入り登録している）がいる' do
      let(:favorited_user) {create(:user)}
      before do
        Favorite.create(user: favorited_user, vtuber: vtuber)
      end

      it '通知データが登録される' do
        vtuber.set_notification_update(current_user)
        expect(current_user.active_notifications.count).to eq 1
        notification = current_user.active_notifications.first
        expect(notification.visited_id).to eq favorited_user.id
        expect(notification.vtuber_id).to eq vtuber.id
        expect(notification.action).to eq "update"
      end
      it '自分宛の通知は既読になる' do
        Favorite.create(user: current_user, vtuber: vtuber)
        vtuber.set_notification_update(current_user)
        notification = current_user.active_notifications.find_by(visited_id: current_user.id)
        expect(notification.checked).to be true
      end
    end

    context '通知相手（お気に入り登録している）がいない' do
      it '通知データが登録されない' do
        vtuber.set_notification_update(current_user)
        expect(Notification.count).to eq 0
      end
    end
  end
end