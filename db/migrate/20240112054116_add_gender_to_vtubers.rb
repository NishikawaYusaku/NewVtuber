class AddGenderToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :gender, :string
  end
end
