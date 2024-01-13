class RemoveHashtagFromVtubers < ActiveRecord::Migration[7.1]
  def change
    remove_column :vtubers, :hashtag
  end
end
