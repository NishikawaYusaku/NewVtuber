class RemoveColumnFromVtubers < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :vtubers, :genders
    remove_index :vtubers, :gender_id
    remove_column :vtubers, :gender_id, :bigint
  end
end
