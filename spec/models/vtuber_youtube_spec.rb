require 'rails_helper'

RSpec.describe VtuberYoutube, type: :model do
  let(:vtuber) { create(:vtuber) }

  describe 'association' do
    context 'vtuber' do
      it 'vtuberがいる' do
        vtuber_youtube = build(:vtuber_youtube, vtuber: vtuber)
        expect(vtuber_youtube).to be_valid
      end
      it 'vtuberがいない' do
        vtuber_youtube = build(:vtuber_youtube, vtuber: nil)
        expect(vtuber_youtube).not_to be_valid
      end
    end
  end
end
