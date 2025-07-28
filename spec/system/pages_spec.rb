require 'rails_helper'

RSpec.describe "Pages", type: :system do
  before do
    page.driver.browser.manage.window.resize_to(1400, 900)
  end

  context 'ログイン前' do
    before do
      visit root_path
    end

    it 'サービス説明が見れる' do
      find("a[href='/pages/about']").click
      expect(page).to have_content 'VTuberは好きですか？'
    end

    it 'お問い合わせが見れる' do
      expect(page).to have_css('[data-testid="footer-query"]')
    end

    it '利用規約が見れる' do
      find("a[href='/pages/terms']").click
      expect(page).to have_content '本規約への同意'
    end

    it 'プライバシーポリシーが見れる' do
      find("a[href='/pages/privacy_policy']").click
      expect(page).to have_content 'お客様から取得する情報'
    end
  end

  context 'ログイン後' do
    before { login }

    it 'サービス説明が見れる' do
      find("a[href='/pages/about']").click
      expect(page).to have_content 'VTuberは好きですか？'
    end

    it 'お問い合わせが見れる' do
      expect(page).to have_css('[data-testid="footer-query"]')
    end

    it '利用規約が見れる' do
      find("a[href='/pages/terms']").click
      expect(page).to have_content '本規約への同意'
    end

    it 'プライバシーポリシーが見れる' do
      find("a[href='/pages/privacy_policy']").click
      expect(page).to have_content 'お客様から取得する情報'
    end
  end
end
