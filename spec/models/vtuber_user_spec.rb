require 'rails_helper'

RSpec.describe VtuberUser, type: :model do
  let(:user) { create(:user) }
  let(:vtuber) { create(:vtuber) }

  describe 'association' do
    context 'user/vtuber' do
      it 'user/vtuberがいる' do
        vtuber_user = build(:vtuber_user, user: user, vtuber: vtuber)
        expect(vtuber_user).to be_valid
      end

      it 'userがいない' do
        vtuber_user = build(:vtuber_user, user: nil, vtuber: vtuber)
        expect(vtuber_user).not_to be_valid
      end

      it 'vtuberがいない' do
        vtuber_user = build(:vtuber_user, user: user, vtuber: nil)
        expect(vtuber_user).not_to be_valid
      end
    end
  end
end
