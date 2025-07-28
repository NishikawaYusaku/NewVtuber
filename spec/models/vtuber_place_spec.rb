require 'rails_helper'

RSpec.describe VtuberPlace, type: :model do
  let(:vtuber) { create(:vtuber) }
  let(:place) { create(:place) }

  describe 'validation' do
    let(:vtuber_place) { build(:vtuber_place) }

    context 'url' do
      it '有効な入力値' do
        expect(vtuber_place).to be_valid
      end

      it '入力されている' do
        vtuber_place.url = ""
        vtuber_place.valid?
        expect(vtuber_place.errors[:url]).to include "を指定してください。"
      end

      it '重複していない' do
        create(:vtuber_place, url: "https://test")
        vtuber_place.url = "https://test"
        vtuber_place.valid?
        expect(vtuber_place.errors[:url]).to include "はすでに存在します"
      end
    end
  end

  describe 'association' do
    context 'vtuber/place' do
      it 'vtuber/placeがいる' do
        vtuber_place = build(:vtuber_place, vtuber: vtuber, place: place)
        expect(vtuber_place).to be_valid
      end

      it 'vtuberがいない' do
        vtuber_place = build(:vtuber_place, vtuber: nil, place: place)
        expect(vtuber_place).not_to be_valid
      end

      it 'placeがいない' do
        vtuber_place = build(:vtuber_place, vtuber: vtuber, place: nil)
        expect(vtuber_place).not_to be_valid
      end
    end
  end
end
