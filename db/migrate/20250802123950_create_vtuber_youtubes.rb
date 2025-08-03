class CreateVtuberYoutubes < ActiveRecord::Migration[7.1]
  def change
    create_table :vtuber_youtubes do |t|
      t.references :vtuber, null: false, foreign_key: true
      t.integer :subscriber_count
      t.integer :video_count
      t.string :latest_video_id
      t.timestamps
    end
  end
end
