class AddUrlToVtuberPlace < ActiveRecord::Migration[7.1]
  def change
    add_column :vtuber_places, :url, :string
  end
end
