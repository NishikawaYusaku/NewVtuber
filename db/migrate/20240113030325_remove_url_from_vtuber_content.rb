class RemoveUrlFromVtuberContent < ActiveRecord::Migration[7.1]
  def change
    remove_column :vtuber_contents, :url
  end
end
