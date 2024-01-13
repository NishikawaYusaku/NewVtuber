class CreateVtuberContents < ActiveRecord::Migration[7.1]
  def change
    create_table :vtuber_contents do |t|
      t.references :vtuber, foreign_key: true
      t.references :content, foreign_key: true

      t.timestamps
    end
  end
end
