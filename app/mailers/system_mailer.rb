class SystemMailer < ApplicationMailer
  def youtube_fetch_failed(errors)
    @errors = errors
    mail(to: ENV.fetch('GMAIL_USERNAME', nil), subject: "[エラー]VTuberのYouTube統計情報の定期更新")
  end
end
