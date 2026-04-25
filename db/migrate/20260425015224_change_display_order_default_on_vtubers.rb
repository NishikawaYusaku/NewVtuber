class ChangeDisplayOrderDefaultOnVtubers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :vtubers, :display_order, from: nil, to: 0
  end
end
