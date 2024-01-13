class RemoveColumnFromVtubers2 < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :vtubers, :places
    remove_index :vtubers, :place_id
    remove_column :vtubers, :place_id, :bigint
  end
end
