require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let!(:vtuber1) { create(:vtuber, name: "vtuber1", name_x: "x1") }
  let!(:vtuber2) { create(:vtuber, name: "vtuber2", name_x: "x2") }
  let!(:vtuber3) { create(:vtuber, name: "vtuber3", name_x: "x3") }
  let!(:place)   { create(:place, id: 1, name: "YouTube") }

  before do
    create(:vtuber_place, vtuber: vtuber1, place: place, url: "https://www.youtube.com/@nijisanji")
    create(:vtuber_place, vtuber: vtuber2, place: place, url: "https://www.youtube.com/@hololive")
    create(:vtuber_place, vtuber: vtuber3, place: place, url: "https://www.youtube.com/@Vspo77")
    page.driver.browser.manage.window.resize_to(1400, 900)
    visit root_path
  end

  context 'ログイン前' do
    describe '通常検索' do
      context '該当プロフィールがある' do
        it 'プロフィールが表示される' do
          find('[data-testid="before-login-normal-search-field"]').set('vtuber1')
          find('[data-testid="before-login-normal-search-button"]').click
          expect(page).to have_content 'vtuber1'
          expect(page).not_to have_content 'vtuber2'
          expect(page).not_to have_content 'vtuber3'
          expect(page).not_to have_content '登録されていません'
        end
      end

      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          find('[data-testid="before-login-normal-search-field"]').set('vtuber4')
          find('[data-testid="before-login-normal-search-button"]').click
          expect(page).to have_content '登録されていません'
          expect(page).not_to have_content 'vtuber'
        end
      end
    end

    describe '詳細検索' do
      describe '単一条件' do
        describe '配信サイト' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '性別' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '誕生日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '誕生日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'デビュー日（年）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'デビュー日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'デビュー日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'タグ' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'チャンネル登録者数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '動画数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end
      end

      describe '複数条件' do
        describe '配信サイト + 所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '性別 + 配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '誕生日（月）+ タグ + いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end
      end
    end
  end

  context 'ログイン後' do
    before { login }

    describe '通常検索' do
      context '該当プロフィールがある' do
        it 'プロフィールが表示される' do
          find('[data-testid="after-login-normal-search-field"]').set('vtuber1')
          find('[data-testid="after-login-normal-search-button"]').click
          expect(page).to have_content 'vtuber1'
          expect(page).not_to have_content 'vtuber2'
          expect(page).not_to have_content 'vtuber3'
          expect(page).not_to have_content '登録されていません'
        end
      end

      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          find('[data-testid="after-login-normal-search-field"]').set('vtuber4')
          find('[data-testid="after-login-normal-search-button"]').click
          expect(page).to have_content '登録されていません'
          expect(page).not_to have_content 'vtuber'
        end
      end
    end

    describe '詳細検索' do
      describe '単一条件' do
        describe '配信サイト' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '性別' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '誕生日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '誕生日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'デビュー日（年）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'デビュー日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'デビュー日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'タグ' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe 'チャンネル登録者数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '動画数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end
      end

      describe '複数条件' do
        describe '配信サイト + 所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '性別 + 配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end

        describe '誕生日（月）+ タグ + いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do

            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              
            end
          end
        end
      end
    end
  end
end
