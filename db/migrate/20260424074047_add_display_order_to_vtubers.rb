class AddDisplayOrderToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :display_order, :integer
    execute "UPDATE vtubers SET display_order = id"
    change_column_null :vtubers, :display_order, false
    add_index :vtubers, :display_order
  end
end
