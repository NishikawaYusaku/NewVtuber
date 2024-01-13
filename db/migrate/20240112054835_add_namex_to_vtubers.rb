class AddNamexToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :name_x, :string
  end
end
