require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) {create(:user, password: 'password', password_confirmation: 'password')}

  context 'ログイン前' do
    describe 'ログイン' do
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

        end
      end
      context 'できない' do
        describe 'メールアドレス' do
          it '入力していない' do

          end
          it '重複している' do
            
          end
        end
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
        describe 'ユーザ名' do
          it '入力していない' do
            
          end
        end
        describe '利用規約/プライバシーポリシー' do
          it '同意してない' do
            
          end
        end
      end
    end

    describe 'パスワードリセット' do
      context 'できる' do
        it 'できる' do

        end
      end
      context 'できない' do
        describe 'メールアドレス' do
          it '入力していない' do

          end
        end
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

    describe 'ユーザページ' do
      it '見れない' do

      end
    end
  end
  
  context 'ログイン後' do
    describe 'ログアウト' do
      it 'できる' do

      end
    end

    describe 'ユーザページ' do
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