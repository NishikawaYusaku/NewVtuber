require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  let!(:vtuber1) { create(:vtuber, name: "vtuber1", name_x: "x1") }
  let!(:place)   { create(:place, id: 1, name: "YouTube") }
  before do
    page.driver.browser.manage.window.resize_to(1400, 900)
    create(:vtuber_place, vtuber: vtuber1, place: place, url: "https://www.youtube.com/@nijisanji")
  end

  context 'ログイン前' do
    it '通知が見れない' do
      expect(page).not_to have_content '通知'
    end
  end

  context 'ログイン後' do
    describe 'プロフィール', focus: true do
      it '通知がある' do
        login
        create(:favorite, user: @user, vtuber: vtuber1)
        find('a.nav-link.active', text: 'ログアウト').click

        create(:user, email: "testsub@com", name: "test", password: "password")
        visit login_path
        fill_in 'email', with: "testsub@com"
        fill_in 'password', with: "password"
        click_button 'ログイン'
        visit edit_vtuber_path(vtuber1)
        click_button '更新'
        find('a.nav-link.active', text: 'ログアウト').click

        visit login_path
        fill_in 'email', with: "test@com"
        fill_in 'password', with: "password"
        click_button 'ログイン'
        expect(page).to have_content '通知'
        click_button 'notification-modal'
        expect(page).to have_content 'プロフィールが更新されました。'
        expect(page).to have_content 'vtuber1'
        expect(page).to have_css('[data-testid="notification-modal-link"]')
        find('[data-testid="notification-modal-link"]').click
        expect(current_path).to eq vtuber_path(vtuber1)
      end
      it '通知がない' do
        login
        click_button 'notification-modal'
        expect(page).to have_content '通知はありません'
      end
    end
  end
end