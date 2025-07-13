require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:vtuber) { create(:vtuber) }
  let(:user) { create(:user) }

  describe 'validation' do
    context 'body' do
      it '有効な入力値' do
        expect(build(:comment)).to be_valid
      end
      it '入力されている' do
        comment = build(:comment, user: user, vtuber: vtuber, body: "")
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to include "を入力してください"
      end
    end
  end

  describe 'association' do
    context 'user/vtuber' do
      it 'user/vtuberがいる' do
        comment = build(:comment, user: user, vtuber: vtuber, body: "test")
        expect(comment).to be_valid
      end
      it 'userがいない' do
        comment = build(:comment, user: nil, vtuber: vtuber, body: "test")
        expect(comment).not_to be_valid
      end
      it 'vtuberがいない' do
        comment = build(:comment, user: user, vtuber: nil, body: "test")
        expect(comment).not_to be_valid
      end
    end
  end
end