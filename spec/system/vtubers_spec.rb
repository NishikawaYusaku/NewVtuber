require 'rails_helper'

RSpec.describe "Vtubers", type: :system do
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
    describe 'プロフィールページ' do
      before do
        expect(page).to have_content 'vtuber1'
        expect(page).to have_content 'vtuber2'
        expect(page).to have_content 'vtuber3'
        find("a[href='/vtubers/#{vtuber1.id}']").click
      end

      describe 'プロフィール' do
        it '全ての項目が正しく表示される' do
          expect(current_path).to eq vtuber_path(vtuber1)
        end
      end

      describe 'お気に入り登録' do
        it 'できない' do
          find("a[data-testid='favorite-login-link']").click
          expect(current_path).to eq login_path
          expect(vtuber1.favorites_count).to eq 0
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
          find('[data-testid="before-login-search"]').click
          expect(page).to have_content 'vtuber1'
          expect(page).not_to have_content 'vtuber2'
          expect(page).not_to have_content 'vtuber3'
          expect(page).not_to have_content '登録されていません'
        end
      end

      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          fill_in 'q', with: 'vtuber4'
          find('[data-testid="before-login-search"]').click
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

    it 'マイページが見れない' do
      expect(page).not_to have_content 'マイページ'
      visit user_path
      expect(page).to have_content 'ログインしてください'
      expect(current_path).to eq login_path
    end
  end

  context 'ログイン後' do
    before { login }

    describe 'プロフィールページ' do
      before do
        expect(page).to have_content 'vtuber1'
        expect(page).to have_content 'vtuber2'
        expect(page).to have_content 'vtuber3'
        find("a[href='/vtubers/#{vtuber1.id}']").click
      end

      describe 'プロフィール' do
        it '全ての項目が正しく表示される' do
          expect(current_path).to eq vtuber_path(vtuber1)
        end
      end

      describe 'お気に入り登録' do
        it 'できる' do
          expect(vtuber1.favorites_count).to eq 0
          expect(page).to have_content '× 0'
          find("a[href='/vtubers/#{vtuber1.id}/favorite']").click
          expect(current_path).to eq vtuber_path(vtuber1)
          expect(page).to have_content '× 1'
          expect(vtuber1.reload.favorites_count).to eq 1
        end

        it '外せる' do
          find("a[href='/vtubers/#{vtuber1.id}/favorite']").click
          expect(vtuber1.reload.favorites_count).to eq 1
          expect(page).to have_content '× 1'
          find("a[href='/vtubers/#{vtuber1.id}/favorite']").click
          expect(current_path).to eq vtuber_path(vtuber1)
          expect(page).to have_content '× 0'
          expect(vtuber1.reload.favorites_count).to eq 0
        end
      end

      describe 'コメント' do
        it '投稿できる' do
          expect(page).to have_button '投稿する'
          expect(page).to have_content 'コメント（0）'
          fill_in 'comment[body]', with: "testcomment"
          click_button '投稿する'
          expect(current_path).to eq vtuber_path(vtuber1)
          expect(page).to have_content 'コメント（1）'
          expect(page).to have_content 'testcomment'
        end

        it '編集できる' do
          comment = create(:comment, user: @user, vtuber: vtuber1, body: "testcomment")
          find("a[href='/vtubers/#{vtuber1.id}/comments/#{comment.id}/edit']").click
          expect(page).to have_button '更新する'
          fill_in "textarea-comment-#{comment.id}", with: "testcomment_edit"
          click_button '更新する'
          expect(page).to have_content 'コメント（1）'
          expect(page).to have_content 'testcomment_edit'
        end

        it '削除できる' do
          comment = create(:comment, user: @user, vtuber: vtuber1, body: "testcomment")
          find("a[href='/vtubers/#{vtuber1.id}/comments/#{comment.id}']").click
          expect(page).to have_content 'コメント（0）'
          expect(page).not_to have_content 'testcomment'
        end
      end
    end

    describe '検索' do
      context '該当プロフィールがある' do
        it 'プロフィールが表示される' do
          fill_in 'q', with: 'vtuber1'
          find('[data-testid="after-login-search"]').click
          expect(page).to have_content 'vtuber1'
          expect(page).not_to have_content 'vtuber2'
          expect(page).not_to have_content 'vtuber3'
          expect(page).not_to have_content '登録されていません'
        end
      end

      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          fill_in 'q', with: 'vtuber4'
          find('[data-testid="after-login-search"]').click
          expect(page).to have_content '登録されていません'
          expect(page).not_to have_content 'vtuber'
        end
      end
    end

    describe 'プロフィール作成' do
      before do
        expect(page).to have_content '設定'
        click_button 'profile-modal'
        expect(page).to have_content 'VTuberのお名前'
        fill_in 'name', with: 'vtuber4'
        click_button '設定する'
      end

      context 'できる' do
        it 'できる' do
          expect(page).to have_content 'VTuberのお名前（必須）'
          expect(page).to have_field('vtuber_name', with: 'vtuber4')
          fill_in 'vtuber_name_x', with: 'x4'
          find('[data-testid="place-select"]').select('YouTube')
          find('[data-testid="place-url"]').set('https://www.youtube.com/@VariumOfficial')
          click_button '登録'
          expect(page).to have_content '× 0'
          expect(page).to have_content '最新動画'
        end
      end

      context 'できない' do
        describe '名前' do
          it '入力してない' do
            fill_in 'vtuber_name', with: ''
            fill_in 'vtuber_name_x', with: 'x4'
            find('[data-testid="place-select"]').select('YouTube')
            find('[data-testid="place-url"]').set('https://www.youtube.com/@VariumOfficial')
            click_button '登録'
            expect(page).to have_content 'VTuberを登録できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end

          it '重複している' do
            fill_in 'vtuber_name', with: 'vtuber1'
            fill_in 'vtuber_name_x', with: 'x4'
            find('[data-testid="place-select"]').select('YouTube')
            find('[data-testid="place-url"]').set('https://www.youtube.com/@VariumOfficial')
            click_button '登録'
            expect(page).to have_content 'VTuberを登録できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end
        end

        describe 'Xのユーザ名' do
          it '重複している' do
            fill_in 'vtuber_name_x', with: 'x1'
            find('[data-testid="place-select"]').select('YouTube')
            find('[data-testid="place-url"]').set('https://www.youtube.com/@VariumOfficial')
            click_button '登録'
            expect(page).to have_content 'VTuberを登録できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end
        end

        describe '配信サイト' do
          it 'サイトを選択してない' do
            fill_in 'vtuber_name_x', with: 'x4'
            find('[data-testid="place-url"]').set('https://www.youtube.com/@VariumOfficial')
            click_button '登録'
            expect(page).to have_content 'VTuberを登録できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end

          it 'URLを入力していない' do
            fill_in 'vtuber_name_x', with: 'x4'
            find('[data-testid="place-select"]').select('YouTube')
            find('[data-testid="place-url"]').set('')
            click_button '登録'
            expect(page).to have_content 'VTuberを登録できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end
        end
      end
    end

    describe 'プロフィール編集' do
      context 'できる' do
        it 'できる' do
          visit edit_vtuber_path(vtuber1)
          fill_in 'vtuber_name', with: 'vtuber10'
          click_button '更新'
          expect(page).to have_content 'vtuber10'
          expect(page).to have_content '最新動画'
        end
      end

      context 'できない' do
        describe '名前' do
          it '入力してない' do
            visit edit_vtuber_path(vtuber1)
            fill_in 'vtuber_name', with: ''
            click_button '更新'
            expect(page).to have_content 'VTuberを更新できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end

          it '重複している' do
            visit edit_vtuber_path(vtuber2)
            fill_in 'vtuber_name', with: ''
            click_button '更新'
            expect(page).to have_content 'VTuberを更新できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end
        end

        describe 'Xのユーザ名' do
          it '重複している' do
            visit edit_vtuber_path(vtuber1)
            fill_in 'vtuber_name_x', with: 'x2'
            click_button '更新'
            expect(page).to have_content 'VTuberを更新できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end
        end

        describe '配信サイト' do
          # サイトの無選択は編集ページではできないためテストは不要
          it 'URLを入力していない' do
            visit edit_vtuber_path(vtuber1)
            find('[data-testid="place-url"]').set('')
            click_button '更新'
            expect(page).to have_content 'VTuberを更新できませんでした'
            expect(page).to have_content 'VTuberのお名前（必須）'
          end
        end

        it '複数人同時編集' do # このままだとエラーが出るが、version確認のif文をupdateif文を覆う形にすれば解消する
          Capybara.using_session(:user1) do
            user1 = create(:user, email: "user1@example.com", password: "password")
            visit login_path
            fill_in 'email', with: user1.email
            fill_in 'password', with: 'password'
            click_button 'ログイン'
            visit edit_vtuber_path(vtuber1)
            fill_in 'vtuber_name', with: '編集A'
          end

          Capybara.using_session(:user2) do
            user2 = create(:user, email: "user2@example.com", password: "password")
            visit login_path
            fill_in 'email', with: user2.email
            fill_in 'password', with: 'password'
            click_button 'ログイン'
            visit edit_vtuber_path(vtuber1)
            fill_in 'vtuber_name', with: '編集B'
            click_button '更新'
            expect(page).to have_content 'VTuberを更新しました'
            expect(vtuber1.reload.version).to eq 1
          end

          Capybara.using_session(:user1) do
            click_button '更新'
            expect(current_path).to eq vtuber_path(vtuber1)
            expect(page).to have_content '他の人が先にプロフィールを更新しました'
            expect(vtuber1.reload.version).to eq 1
          end
        end
      end
    end

    describe 'マイページ' do
      describe 'お気に入り登録' do
        context 'している' do
          before do
            create(:favorite, user: @user, vtuber: vtuber1)
            expect(vtuber1.reload.favorites_count).to eq 1
            visit user_path
            expect(page).to have_content 'vtuber1'
            expect(page).to have_content '見る'
            expect(page).to have_css('[data-testid="mypage-heart"]')
          end

          it 'プロフィールを見に行ける' do
            find("a[href='/vtubers/#{vtuber1.id}']").click
            expect(current_path).to eq vtuber_path(vtuber1)
          end

          it 'お気に入りを外せる', :js do
            find('[data-testid="mypage-heart"]').click
            expect(page).not_to have_content 'vtuber1'
          end
        end

        context 'していない' do
          it '何も表示されない' do
            visit user_path
            expect(page).to have_content 'いません'
          end
        end
      end
    end
  end
end
