class AddIndexToVtuberYoutube < ActiveRecord::Migration[7.1]
  def change
    add_index :vtuber_youtubes, :channel_id, unique: true
  end
end
