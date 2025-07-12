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
end
