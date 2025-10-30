class AddColumnBloodtypeToVtuber < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :blood_type, :string
  end
end
