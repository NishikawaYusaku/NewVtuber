class DeleteColumnFromVtuber < ActiveRecord::Migration[7.1]
  def change
    remove_column :vtubers, :fan_name, :string
  end
end
