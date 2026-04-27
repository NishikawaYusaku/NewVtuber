class SystemMailer < ApplicationMailer
  def youtube_fetch_failed(errors)
    @errors = errors
    mail(to: ENV.fetch('GMAIL_USERNAME', nil), subject: "[エラー]VTuberのYouTube統計情報の定期更新")
  end

  def display_order_failed(error_message)
    @error_message = error_message
    mail(to: ENV.fetch('GMAIL_USERNAME', nil), subject: "[エラー]トップページのプロフィール表示順の定期ランダム決定")
  end
end
