namespace :display_order do
  desc "トップページのプロフィール表示順を定期的にランダム変更"
  task change: :environment do
    begin
      Vtuber.transaction do
        Vtuber.order(Arel.sql("RANDOM()")).each.with_index(1) do |vtuber, index|
          vtuber.update_column(:display_order, index)
        end
      end
      completion_message = "#{Time.current}：[完了]トップページのプロフィール表示順の定期ランダム決定"
      Rails.logger.info completion_message
      puts completion_message
    rescue => e
      error_message1 = "#{Time.current}：[エラー]トップページのプロフィール表示順の定期ランダム決定"
      error_message2 = "#{Time.current}：#{e.message}"
      Rails.logger.error error_message1
      Rails.logger.error error_message2
      puts error_message1
      puts error_message2
      SystemMailer.display_order_failed(e.message).deliver_now
    end
  end
end
