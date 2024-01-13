class RemoveContentFromVtubers < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :vtubers, :contents
    remove_index :vtubers, :content_id
    remove_column :vtubers, :content_id, :bigint
  end
end
