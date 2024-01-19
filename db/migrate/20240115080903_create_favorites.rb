class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vtuber, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :vtuber_id], unique: true
    end
  end
end
