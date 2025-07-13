require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) {build(:tag)}

  describe 'validation' do
    context '名前' do
      it '入力されている' do
        tag.name = ""
        tag.valid?
        expect(tag.errors[:name]).to include "を入力してください"
      end
      it '重複していない' do
        create(:tag, name: "test")
        tag.name = "test"
        tag.valid?
        expect(tag.errors[:name]).to include "はすでに存在します"
      end
    end
  end

  describe 'association' do
    let(:vtuber) {create(:vtuber)}

    context 'vtuber_tags/vtubers' do
      it 'vtuber_tags/vtubers' do
        create(:vtuber_tag, vtuber: vtuber, tag: tag)
        expect(tag.vtubers.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:vtuber_tag, vtuber: vtuber, tag: tag)
        expect {tag.destroy}.to change {VtuberTag.count}.by(-1)
      end
    end
  end
end