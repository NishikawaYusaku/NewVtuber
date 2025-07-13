require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) {create(:user)}
  let(:vtuber) {create(:vtuber)}

  describe 'association' do
    context 'user/vtuber' do
      it 'user/vtuberがいる' do
        favorite = build(:favorite, user: user, vtuber: vtuber)
        expect(favorite).to be_valid
      end
      it 'userがいない' do
        favorite = build(:favorite, user: nil, vtuber: vtuber)
        expect(favorite).not_to be_valid
      end
      it 'vtuberがいない' do
        favorite = build(:favorite, user: user, vtuber: nil)
        expect(favorite).not_to be_valid
      end
    end
  end
end
