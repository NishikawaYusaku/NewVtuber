class AddColumnHeightToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :height, :integer
  end
end
