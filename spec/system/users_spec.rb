require 'rails_helper'

RSpec.describe "Users", type: :system do
  context 'ログイン前' do
    describe 'ログイン' do
      let(:user) {create(:user, email: "test@com", name: "test", password: 'password')}
      
      context 'できる' do
        it 'できる' do
          login(user)
          expect(current_path).to eq root_path
        end
      end
      context 'できない' do
        it 'メールアドレスが一致しない' do
          visit login_path
          fill_in 'email', with: ""
          fill_in 'password', with: "password"
          click_button 'ログイン'
          expect(page).to have_content "ログインできませんでした"
        end
        it 'パスワードが一致しない' do
          visit login_path
          fill_in 'email', with: user.email
          fill_in 'password', with: ""
          click_button 'ログイン'
          expect(page).to have_content "ログインできませんでした"
        end
        it 'メールアドレスとパスワードが一致しない' do
          visit login_path
          fill_in 'email', with: ""
          fill_in 'password', with: ""
          click_button 'ログイン'
          expect(page).to have_content "ログインできませんでした"
        end
      end
    end
    
    describe 'ユーザ登録' do
      context 'できる' do
        it 'できる' do
          visit new_user_path
          fill_in 'メールアドレス', with: "test@com"
          fill_in 'user[password]', with: "password"
          fill_in 'user[password_confirmation]', with: "password"
          fill_in 'ユーザー名', with: "test"
          check 'user_agreement'
          click_button '登録'
          expect(page).to have_content "ユーザーを登録しました"
        end
      end
      context 'できない' do
        describe 'メールアドレス' do
          it '入力していない' do
            visit new_user_path
            fill_in 'メールアドレス', with: ""
            fill_in 'user[password]', with: "password"
            fill_in 'user[password_confirmation]', with: "password"
            fill_in 'ユーザー名', with: "test"
            check 'user_agreement'
            click_button '登録'
            expect(page).to have_content "ユーザーを登録できませんでした"
          end
          it '重複している' do
            create(:user, email: "test@com", name: "test", password: 'password')
            visit new_user_path
            fill_in 'メールアドレス', with: "test@com"
            fill_in 'user[password]', with: "password"
            fill_in 'user[password_confirmation]', with: "password"
            fill_in 'ユーザー名', with: "test"
            check 'user_agreement'
            click_button '登録'
            expect(page).to have_content "ユーザーを登録できませんでした"
          end
        end
        describe 'パスワード' do
          it '入力していない' do
            visit new_user_path
            fill_in 'メールアドレス', with: "test@com"
            fill_in 'user[password]', with: ""
            fill_in 'user[password_confirmation]', with: "password"
            fill_in 'ユーザー名', with: "test"
            check 'user_agreement'
            click_button '登録'
            expect(page).to have_content "ユーザーを登録できませんでした"
          end
          it '8文字未満' do
            visit new_user_path
            fill_in 'メールアドレス', with: "test@com"
            fill_in 'user[password]', with: "pass"
            fill_in 'user[password_confirmation]', with: "password"
            fill_in 'ユーザー名', with: "test"
            check 'user_agreement'
            click_button '登録'
            expect(page).to have_content "ユーザーを登録できませんでした"
          end
        end
        describe 'パスワード確認' do
          it '一致しない' do
            visit new_user_path
            fill_in 'メールアドレス', with: "test@com"
            fill_in 'user[password]', with: "password"
            fill_in 'user[password_confirmation]', with: "pass"
            fill_in 'ユーザー名', with: "test"
            check 'user_agreement'
            click_button '登録'
            expect(page).to have_content "ユーザーを登録できませんでした"
          end
        end
        describe 'ユーザ名' do
          it '入力していない' do
            visit new_user_path
            fill_in 'メールアドレス', with: "test@com"
            fill_in 'user[password]', with: "password"
            fill_in 'user[password_confirmation]', with: "pass"
            fill_in 'ユーザー名', with: ""
            check 'user_agreement'
            click_button '登録'
            expect(page).to have_content "ユーザーを登録できませんでした"
          end
        end
        describe '利用規約/プライバシーポリシー' do
          it '同意してない' do
            visit new_user_path
            fill_in 'メールアドレス', with: "test@com"
            fill_in 'user[password]', with: "password"
            fill_in 'user[password_confirmation]', with: "pass"
            fill_in 'ユーザー名', with: "test"
            uncheck 'user_agreement'
            click_button '登録'
            expect(page).to have_content "ユーザーを登録できませんでした"
          end
        end
      end
    end

    describe 'パスワードリセット' do
      context 'できる' do
        it 'できる' do
          create(:user, email: "test@com", name: "test", password: 'password')
          visit new_password_reset_path
          fill_in 'email', with: "test@com"
          click_button '送信'
          expect(ActionMailer::Base.deliveries.size).to eq 1

          mail = ActionMailer::Base.deliveries.last
          body = mail.text_part&.decoded || mail.html_part&.decoded
          reset_url = body.match(/href="([^"]+)"/)[1]
          uri = URI.parse(reset_url)
          visit uri.path
          expect(page).to have_content 'パスワードの変更'

          fill_in 'user[password]', with: 'newpassword'
          fill_in 'user[password_confirmation]', with: 'newpassword'
          click_button '保存'
          expect(page).to have_content 'パスワードを変更しました'
        end
      end
      context 'できない' do
        describe 'メールアドレス' do
          it '一致しない' do
            create(:user, email: "test@com", name: "test", password: 'password')
            visit new_password_reset_path
            fill_in 'email', with: ""
            click_button '送信'
            expect(ActionMailer::Base.deliveries.size).to eq 0
          end
        end
        describe 'パスワード' do
          it '入力していない' do
            create(:user, email: "test@com", name: "test", password: 'password')
            visit new_password_reset_path
            fill_in 'email', with: "test@com"
            click_button '送信'
            mail = ActionMailer::Base.deliveries.last
            body = mail.text_part&.decoded || mail.html_part&.decoded
            reset_url = body.match(/href="([^"]+)"/)[1]
            uri = URI.parse(reset_url)
            visit uri.path
            fill_in 'user[password]', with: ''
            fill_in 'user[password_confirmation]', with: 'newpassword'
            click_button '保存'
            expect(page).to have_content 'パスワードを変更できませんでした'
          end
          it '8文字未満' do
            create(:user, email: "test@com", name: "test", password: 'password')
            visit new_password_reset_path
            fill_in 'email', with: "test@com"
            click_button '送信'
            mail = ActionMailer::Base.deliveries.last
            body = mail.text_part&.decoded || mail.html_part&.decoded
            reset_url = body.match(/href="([^"]+)"/)[1]
            uri = URI.parse(reset_url)
            visit uri.path
            fill_in 'user[password]', with: 'pass'
            fill_in 'user[password_confirmation]', with: 'pass'
            click_button '保存'
            expect(page).to have_content 'パスワードを変更できませんでした'
          end
        end
        describe 'パスワード確認' do
          it '一致しない' do
            create(:user, email: "test@com", name: "test", password: 'password')
            visit new_password_reset_path
            fill_in 'email', with: "test@com"
            click_button '送信'
            mail = ActionMailer::Base.deliveries.last
            body = mail.text_part&.decoded || mail.html_part&.decoded
            reset_url = body.match(/href="([^"]+)"/)[1]
            uri = URI.parse(reset_url)
            visit uri.path
            fill_in 'user[password]', with: 'newpassword'
            fill_in 'user[password_confirmation]', with: ''
            click_button '保存'
            expect(page).to have_content 'パスワードを変更できませんでした'
          end
        end
      end
    end

    describe 'マイページ' do
      it '見れない' do
        visit user_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
  end
  
  context 'ログイン後' do
    before do
      # create(:user, email: "test@com", name: "test", password: 'password')
      login
    end
    describe 'ログアウト', focus: true do
      it 'できる' do
        page.driver.browser.manage.window.resize_to(1400, 900)
        find('a.nav-link.active', text: 'ログアウト').click
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq root_path
      end
    end

    describe 'マイページ' do
      describe 'メールアドレスの変更' do
        context 'できる' do
          it 'できる' do
            
          end
        end
        context 'できない' do
          it '入力していない' do

          end
          it '重複している' do
            
          end
        end
      end
      describe 'パスワードの変更' do
        context 'できる' do
          it 'できる' do
            
          end
        end
        context 'できない' do
          describe 'パスワード' do
            it '入力していない' do

            end
            it '8文字未満' do

            end
          end
          describe 'パスワード確認' do
            it '一致しない' do

            end
          end
        end
      end
      describe 'ユーザ名の変更' do
        context 'できる' do
          it 'できる' do
            
          end
        end
        context 'できない' do
          it '入力していない' do
            
          end
        end
      end
    end
  end
end