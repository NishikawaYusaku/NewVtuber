class AddColumnToVtuber < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :version, :integer, default: 0, null: false
  end
end
