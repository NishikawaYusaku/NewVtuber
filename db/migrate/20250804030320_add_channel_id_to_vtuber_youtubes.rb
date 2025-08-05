class AddChannelIdToVtuberYoutubes < ActiveRecord::Migration[7.1]
  def change
    add_column :vtuber_youtubes, :channel_id, :string
  end
end
