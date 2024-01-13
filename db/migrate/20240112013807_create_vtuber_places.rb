class CreateVtuberPlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :vtuber_places do |t|
      t.references :vtuber, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
