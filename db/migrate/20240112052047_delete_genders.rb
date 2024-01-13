class DeleteGenders < ActiveRecord::Migration[7.1]
  def change
    drop_table :genders
  end
end
