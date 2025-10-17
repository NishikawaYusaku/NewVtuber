class AddColumnLanguageToVtuber < ActiveRecord::Migration[7.1]
  def change
    add_column :vtubers, :language, :string
  end
end
