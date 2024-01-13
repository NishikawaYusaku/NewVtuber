class CreateVtubers < ActiveRecord::Migration[7.1]
  def change
    create_table :vtubers do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :image
      t.date :debut_date
      t.string :fan_name
      t.string :hashtag
      t.string :like
      t.string :unlike

      t.timestamps
    end
  end
end
