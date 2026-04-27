namespace :display_order do
  desc "トップページのプロフィール表示順を定期的にランダム変更"
  task change: :environment do
    begin
      Vtuber.transaction do
        Vtuber.order(Arel.sql("RANDOM()")).each.with_index(1) do |vtuber, index|
          vtuber.update_column(:display_order, index)
        end
      end
      Rails.logger.info "#{Time.current}：[完了]トップページのプロフィール表示順の定期ランダム決定"
    rescue => e
      Rails.logger.error "#{Time.current}：[エラー]トップページのプロフィール表示順の定期ランダム決定"
      Rails.logger.error "#{Time.current}：#{e.message}"
      SystemMailer.display_order_failed(e.message).deliver_now
    end
  end
end
