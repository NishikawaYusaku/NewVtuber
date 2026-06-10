class RemoveCheckedFromNotifications < ActiveRecord::Migration[7.1]
  def change
    remove_column :notifications, :checked, :boolean
  end
end
