class ChangeFavoritesCountDefaultOnVtubers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :vtubers, :favorites_count, 0
  end
end
