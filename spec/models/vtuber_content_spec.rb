require 'rails_helper'

RSpec.describe VtuberContent, type: :model do
  let(:vtuber) { create(:vtuber) }
  let(:content) { create(:content) }

  describe 'association' do
    context 'vtuber/content' do
      it 'vtuber/contentがいる' do
        vtuber_content = build(:vtuber_content, vtuber: vtuber, content: content)
        expect(vtuber_content).to be_valid
      end

      it 'vtuberがいない' do
        vtuber_content = build(:vtuber_content, vtuber: nil, content: content)
        expect(vtuber_content).not_to be_valid
      end

      it 'contentがいない' do
        vtuber_content = build(:vtuber_content, vtuber: vtuber, content: nil)
        expect(vtuber_content).not_to be_valid
      end
    end
  end
end
