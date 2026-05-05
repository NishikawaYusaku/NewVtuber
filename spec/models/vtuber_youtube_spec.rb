require 'rails_helper'

RSpec.describe VtuberYoutube, type: :model do
  let(:vtuber) { create(:vtuber) }

  describe 'validation' do
    let(:vtuber_youtube) { build(:vtuber_youtube) }

    context 'channel_id' do
      it '有効な入力値' do
        expect(vtuber_youtube).to be_valid
      end

      it '重複していない' do
        create(:vtuber_youtube, channel_id: "UCX7YkU9nEeaoZbkVLVajcMg")
        vtuber_youtube.channel_id = "UCX7YkU9nEeaoZbkVLVajcMg"
        vtuber_youtube.valid?
        expect(vtuber_youtube.errors[:channel_id]).to include "はすでに存在します"
      end
    end
  end

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
