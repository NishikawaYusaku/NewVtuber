class AddUrlToVtuberContent < ActiveRecord::Migration[7.1]
  def change
    add_column :vtuber_contents, :url, :string
  end
end
