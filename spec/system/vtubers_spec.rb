require 'rails_helper'

RSpec.describe "Vtubers", type: :system do
  let!(:vtuber1) { create(:vtuber, name: "vtuber1", name_x: "x1") }
  let!(:vtuber2) { create(:vtuber, name: "vtuber2", name_x: "x2") }
  let!(:vtuber3) { create(:vtuber, name: "vtuber3", name_x: "x3") }
  let!(:place)   { create(:place, name: "YouTube") }
  before do
    create(:vtuber_place, vtuber: vtuber1, place: place, url: "https://www.youtube.com/@nijisanji")
    create(:vtuber_place, vtuber: vtuber2, place: place, url: "https://www.youtube.com/@hololive")
    create(:vtuber_place, vtuber: vtuber3, place: place, url: "https://www.youtube.com/@Vspo77")
    page.driver.browser.manage.window.resize_to(1400, 900)
    visit root_path
  end
  context 'ログイン前' do
    describe 'プロフィールページ' do
      before do
        expect(page).to have_content 'vtuber1'
        expect(page).to have_content 'vtuber2'
        expect(page).to have_content 'vtuber3'
        find("a[href='/vtubers/#{vtuber1.id}']").click
      end
      describe 'プロフィール' do
        it '全ての項目が正しく表示される' do
          expect(page).to have_content '所属'
        end
      end
      describe 'お気に入り登録' do
        it 'できない' do
          find("a[data-testid='favorite-login-link']").click
          expect(current_path).to eq login_path
        end
      end
      describe 'コメント' do
        it '投稿できない' do
          expect(page).not_to have_button '投稿する'
        end
      end
    end
    describe '検索' do
      context '該当プロフィールがある' do
        it 'プロフィールが表示される' do
          fill_in 'q', with: 'vtuber1'
          find('[data-testid="search"]').click
          expect(page).to have_content 'vtuber1'
          expect(page).not_to have_content 'vtuber2'
          expect(page).not_to have_content 'vtuber3'
          expect(page).not_to have_content '登録されていません'
        end
      end
      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          fill_in 'q', with: 'vtuber4'
          find('[data-testid="search"]').click
          expect(page).to have_content '登録されていません'
          expect(page).not_to have_content 'vtuber'
        end
      end
    end
    it 'プロフィール作成ができない' do
      expect(page).not_to have_content '設定'
      visit new_vtuber_path
      expect(page).to have_content 'ログインしてください'
      expect(current_path).to eq login_path
    end
    it 'プロフィール編集ができない' do
      expect(page).not_to have_content '設定'
      visit edit_vtuber_path(vtuber1)
      expect(page).to have_content 'ログインしてください'
      expect(current_path).to eq login_path
    end
    it 'ユーザページが見れない',focus: true do
      expect(page).not_to have_content 'マイページ'
      visit user_path
      expect(page).to have_content 'ログインしてください'
      expect(current_path).to eq login_path
      
    end
  end

  context 'ログイン後' do
    describe 'プロフィールページ' do
      describe 'プロフィール' do
        it '全ての項目が正しく表示される' do

        end
      end
      describe 'お気に入り登録' do
        it 'できる' do
          
        end
        it '外せる' do

        end
      end
      describe 'コメント' do
        it '投稿できる' do
          
        end
        it '編集できる' do
          
        end
        it '削除できる' do
          
        end
      end
    end
    describe '検索' do
      context '該当プロフィールがある' do
        it 'プロフィールが表示される' do

        end
      end
      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          
        end
      end
    end
    describe 'プロフィール作成' do
      context 'できる' do
        it 'できる' do

        end
      end
      context 'できない' do
        describe '名前' do
          it '入力してない' do

          end
          it '重複している' do
            
          end
        end
        describe 'Xのユーザ名' do
          it '重複している' do
            
          end
        end
        describe '配信サイト' do
          it 'サイトを選択してない' do
            
          end
          it 'URLを入力していない' do
            
          end
        end
      end
    end
    describe 'プロフィール編集' do
      context 'できる' do
        it 'できる' do

        end
      end
      context 'できない' do
        describe '名前' do
          it '入力してない' do

          end
          it '重複している' do
            
          end
        end
        describe 'Xのユーザ名' do
          it '重複している' do
            
          end
        end
        describe '配信サイト' do
          it 'サイトを選択してない' do
            
          end
          it 'URLを入力していない' do
            
          end
        end
      end
    end
    describe 'ユーザページ' do
      describe 'お気に入り登録' do
        context 'している' do
          it 'プロフィールを見に行ける' do

          end
          it 'お気に入りを外せる' do

          end
        end
        context 'していない' do
          it '何も表示されない' do

          end
        end
      end
    end
  end
end