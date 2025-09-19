require 'rails_helper'

RSpec.describe "Searches", type: :system, focus: true do
  let!(:vtuber1_youtube) { create(:vtuber, name: "vtuber1_youtube", affiliation: "にじさんじ", gender: "女性", birthday: Date.new(0o001, 1, 31), debut_date: Date.new(2018, 1, 31)) }
  let!(:vtuber2_twitch) { create(:vtuber, name: "vtuber2_twitch", affiliation: "個人", gender: "男性", birthday: Date.new(0o001, 6, 6), debut_date: Date.new(2025, 6, 6)) }
  let!(:place_youtube) { create(:place, name: "YouTube") }
  let!(:place_twitch) { create(:place, name: "Twitch") }
  let!(:content_game) { create(:content, name: "ゲーム") }
  let!(:content_song) { create(:content, name: "歌") }
  let!(:tag1) { create(:tag, name: "tag1") }
  let!(:tag2) { create(:tag, name: "tag2") }
  let!(:user) { create(:user, email: "user1@example.com", password: "password") }

  before do
    create(:vtuber_place, vtuber: vtuber1_youtube, place: place_youtube, url: "https://www.youtube.com/@nijisanji")
    create(:vtuber_place, vtuber: vtuber2_twitch, place: place_twitch, url: "https://www.twitch.tv/twitch")
    create(:vtuber_content, vtuber: vtuber1_youtube, content: content_game)
    create(:vtuber_content, vtuber: vtuber2_twitch, content: content_song)
    create(:vtuber_tag, vtuber: vtuber1_youtube, tag: tag1)
    create(:vtuber_tag, vtuber: vtuber2_twitch, tag: tag2)
    create(:favorite, user: user, vtuber: vtuber1_youtube)
    create(:vtuber_youtube, vtuber: vtuber1_youtube, subscriber_count: 1_830_000, video_count: 2737)
    page.driver.browser.manage.window.resize_to(1400, 900)
    visit root_path
  end

  context 'ログイン前' do
    describe '通常検索' do
      context '該当プロフィールがある' do
        it 'プロフィールが表示される' do
          find('[data-testid="ns-field"]').set('vtuber1_youtube')
          find('[data-testid="ns-button"]').click
          expect(page).to have_content 'vtuber1_youtube'
          expect(page).not_to have_content 'vtuber2_twitch'
          expect(page).not_to have_content 'vtuber3_youtube'
          expect(page).not_to have_content '登録されていません'
        end
      end

      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          find('[data-testid="ns-field"]').set('vtuber4_twitch')
          find('[data-testid="ns-button"]').click
          expect(page).to have_content '登録されていません'
          expect(page).not_to have_content 'vtuber4_twitch'
        end
      end
    end

    describe '詳細検索' do
      before do
        click_link '詳細検索'
        expect(current_path).to eq search_path
      end

      describe '単一条件' do
        describe '配信サイト' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              choose 'YouTube'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              choose 'YouTube'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check 'にじさんじ'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示される' do
              check 'にじさんじ'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '性別' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check '女性'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              check '女性'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '誕生日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '誕生日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_birthday_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_birthday_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'デビュー日（年）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_debut_date_year_eq").find("option[value='2018']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_debut_date_year_eq").find("option[value='2018']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'デビュー日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_debut_date_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_debut_date_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'デビュー日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_debut_date_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_debut_date_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check 'ゲーム'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              check 'ゲーム'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'タグ' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check 'tag1'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示される' do
              check 'tag1'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find('#q_favorites_count_gteq').set(0)
              find('#q_favorites_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find('#q_favorites_count_gteq').set(2)
              find('#q_favorites_count_lteq').set(3)
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'youtube'
            end
          end
        end

        describe 'チャンネル登録者数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find('#q_vtuber_youtube_subscriber_count_gteq').set(0)
              find('#q_vtuber_youtube_subscriber_count_lteq').set(10_000_000)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find('#q_vtuber_youtube_subscriber_count_gteq').set(0)
              find('#q_vtuber_youtube_subscriber_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'youtube'
            end
          end
        end

        describe '動画数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find('#q_vtuber_youtube_video_count_gteq').set(0)
              find('#q_vtuber_youtube_video_count_lteq').set(10_000)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find('#q_vtuber_youtube_video_count_gteq').set(0)
              find('#q_vtuber_youtube_video_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'youtube'
            end
          end
        end
      end

      describe '複数条件' do
        describe '配信サイト + 所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              choose 'YouTube'
              check 'にじさんじ'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '詳細検索の結果：　1'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              choose 'YouTube'
              check '個人'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '登録されていません'
            end
          end
        end

        describe '性別 + 配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check '女性'
              check 'ゲーム'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '詳細検索の結果：　1'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              check '女性'
              check '歌'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '登録されていません'
            end
          end
        end

        describe '誕生日（月）+ タグ + いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              check 'tag1'
              find('#q_favorites_count_gteq').set(0)
              find('#q_favorites_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '詳細検索の結果：　1'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              check 'tag2'
              find('#q_favorites_count_gteq').set(0)
              find('#q_favorites_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '登録されていません'
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
          find('[data-testid="ns-field"]').set('vtuber1_youtube')
          find('[data-testid="ns-button"]').click
          expect(page).to have_content 'vtuber1_youtube'
          expect(page).not_to have_content 'vtuber2_twitch'
          expect(page).not_to have_content 'vtuber3_youtube'
          expect(page).not_to have_content '登録されていません'
        end
      end

      context '該当プロフィールがない' do
        it 'プロフィールが表示されない' do
          find('[data-testid="ns-field"]').set('vtuber4_twitch')
          find('[data-testid="ns-button"]').click
          expect(page).to have_content '登録されていません'
          expect(page).not_to have_content 'vtuber4_twitch'
        end
      end
    end

    describe '詳細検索' do
      before do
        click_link '詳細検索'
        expect(current_path).to eq search_path
      end

      describe '単一条件' do
        describe '配信サイト' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              choose 'YouTube'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              choose 'YouTube'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check 'にじさんじ'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示される' do
              check 'にじさんじ'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '性別' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check '女性'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              check '女性'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '誕生日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '誕生日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_birthday_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_birthday_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'デビュー日（年）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_debut_date_year_eq").find("option[value='2018']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_debut_date_year_eq").find("option[value='2018']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'デビュー日（月）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_debut_date_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_debut_date_month_eq").find("option[value='1']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'デビュー日（日）' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_debut_date_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_debut_date_day_eq").find("option[value='31']").select_option
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe '配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check 'ゲーム'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              check 'ゲーム'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'タグ' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check 'tag1'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示される' do
              check 'tag1'
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'twitch'
            end
          end
        end

        describe 'いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find('#q_favorites_count_gteq').set(0)
              find('#q_favorites_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find('#q_favorites_count_gteq').set(2)
              find('#q_favorites_count_lteq').set(3)
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'youtube'
            end
          end
        end

        describe 'チャンネル登録者数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find('#q_vtuber_youtube_subscriber_count_gteq').set(0)
              find('#q_vtuber_youtube_subscriber_count_lteq').set(10_000_000)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find('#q_vtuber_youtube_subscriber_count_gteq').set(0)
              find('#q_vtuber_youtube_subscriber_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'youtube'
            end
          end
        end

        describe '動画数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find('#q_vtuber_youtube_video_count_gteq').set(0)
              find('#q_vtuber_youtube_video_count_lteq').set(10_000)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content 'youtube'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find('#q_vtuber_youtube_video_count_gteq').set(0)
              find('#q_vtuber_youtube_video_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).not_to have_content 'youtube'
            end
          end
        end
      end

      describe '複数条件' do
        describe '配信サイト + 所属' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              choose 'YouTube'
              check 'にじさんじ'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '詳細検索の結果：　1'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              choose 'YouTube'
              check '個人'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '登録されていません'
            end
          end
        end

        describe '性別 + 配信ジャンル' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              check '女性'
              check 'ゲーム'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '詳細検索の結果：　1'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              check '女性'
              check '歌'
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '登録されていません'
            end
          end
        end

        describe '誕生日（月）+ タグ + いいね数' do
          context '該当プロフィールがある' do
            it 'プロフィールが表示される' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              check 'tag1'
              find('#q_favorites_count_gteq').set(0)
              find('#q_favorites_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '詳細検索の結果：　1'
            end
          end

          context '該当プロフィールがない' do
            it 'プロフィールが表示されない' do
              find("#q_birthday_month_eq").find("option[value='1']").select_option
              check 'tag2'
              find('#q_favorites_count_gteq').set(0)
              find('#q_favorites_count_lteq').set(1)
              find('[data-testid="fs-button"]').click
              expect(page).to have_content '登録されていません'
            end
          end
        end
      end
    end
  end
end
