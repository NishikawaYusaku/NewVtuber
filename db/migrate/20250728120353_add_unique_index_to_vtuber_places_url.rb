class AddUniqueIndexToVtuberPlacesUrl < ActiveRecord::Migration[7.1]
  def change
    add_index :vtuber_places, :url, unique: true
  end
end
