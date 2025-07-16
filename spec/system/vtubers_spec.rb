require 'rails_helper'

RSpec.describe "Vtubers", type: :system do
  context 'ログイン前' do
    describe 'プロフィールページ' do
      describe 'プロフィール' do
        it '全ての項目が正しく表示される' do

        end
      end
      describe 'お気に入り登録' do
        it 'できない' do
          
        end
      end
      describe 'コメント' do
        it '投稿できない' do
          
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
    it 'プロフィール作成ができない' do
      
    end
    it 'プロフィール編集ができない' do
      
    end
    it 'ユーザページが見れない' do
      
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