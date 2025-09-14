class AddFavoritesCountToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :favorites_count, :integer
  end
end
