require 'rails_helper'

RSpec.describe Content, type: :model do
  let(:content) {create(:content)}
  let(:vtuber) {create(:vtuber)}

  describe 'association' do
    context 'vtuber_contents/vtubers' do
      it 'vtuber_contents/vtubers' do
        create(:vtuber_content, vtuber: vtuber, content: content)
        expect(content.vtubers.count).to eq 1
      end
      it 'dependent: :destroy' do
        create(:vtuber_content, vtuber: vtuber, content: content)
        expect {content.destroy}.to change {VtuberContent.count}.by(-1)
      end
    end
  end
end