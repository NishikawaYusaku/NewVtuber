require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:place) {create(:place)}
  let(:vtuber) {create(:vtuber)}

  describe 'association' do
    context 'vtuber_places/vtubers' do
      it 'vtuber_places/vtubers' do
        create(:vtuber_place, vtuber: vtuber, place: place)
        expect(place.vtubers.count).to eq 1
      end
      it 'dpendent: :destroy' do
        create(:vtuber_place, vtuber: vtuber, place: place)
        expect {place.destroy}.to change {VtuberPlace.count}.by(-1)
      end
    end
  end
end