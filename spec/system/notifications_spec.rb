require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  context 'ログイン前', focus: true do
    it '通知が見れない' do
      expect(page).not_to have_content '通知'
    end
  end

  context 'ログイン後' do
    it '通知の状況が既読(true)になる' do

    end
    describe 'プロフィール' do
      it '見に行ける' do
        
      end
    end
  end
end