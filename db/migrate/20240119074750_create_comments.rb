class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vtuber, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
