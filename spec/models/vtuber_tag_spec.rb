require 'rails_helper'

RSpec.describe VtuberTag, type: :model do
  let(:vtuber) {create(:vtuber)}
  let(:tag) {create(:tag)}

  describe 'validation' do
    before do
      vtuber = create(:vtuber)
      tag = create(:tag)
    end

    context 'tag_id' do
      it 'vtuber_idが同じ場合は重複を許さない' do
        create(:vtuber_tag, vtuber: vtuber, tag: tag)
        vtuber_tag = build(:vtuber_tag, vtuber: vtuber, tag: tag)
        expect(vtuber_tag).not_to be_valid
      end
      it 'vtuber_idが違う場合は重複を許す' do
        create(:vtuber_tag, vtuber: vtuber, tag: tag)
        vtuber.id = vtuber.id + 1
        vtuber_tag = build(:vtuber_tag, vtuber: vtuber, tag: tag)
        expect(vtuber_tag).to be_valid
      end
    end
  end

  describe 'association' do
    context 'vtuber/tag' do
      it 'vtuber/tagがいる' do
        vtuber_tag = build(:vtuber_tag, vtuber: vtuber, tag: tag)
        expect(vtuber_tag).to be_valid
      end
      it 'vtuberがいない' do
        vtuber_tag = build(:vtuber_tag, vtuber: nil, tag: tag)
        expect(vtuber_tag).not_to be_valid
      end
      it 'tagがいない' do
        vtuber_tag = build(:vtuber_tag, vtuber: vtuber, tag: nil)
        expect(vtuber_tag).not_to be_valid
      end
    end
  end
end