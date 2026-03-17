class SystemMailer < ApplicationMailer
  def youtube_fetch_failed(errors)
    @errors = errors
    mail(to: ENV['GMAIL_USERNAME'], subject: "[エラー]VTuberのYouTube統計情報の定期更新")
  end
end
