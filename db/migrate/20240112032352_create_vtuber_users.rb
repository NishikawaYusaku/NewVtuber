class CreateVtuberUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :vtuber_users do |t|
      t.references :user, foreign_key: true
      t.references :vtuber, foreign_key: true

      t.timestamps
    end
  end
end
