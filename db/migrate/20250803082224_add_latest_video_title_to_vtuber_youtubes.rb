class AddLatestVideoTitleToVtuberYoutubes < ActiveRecord::Migration[7.1]
  def change
    add_column :vtuber_youtubes, :latest_video_title, :string
  end
end
