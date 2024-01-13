class AddReferenceToVtubers < ActiveRecord::Migration[7.1]
  def change
    add_reference :vtubers, :gender, foreign_key: true
    add_reference :vtubers, :place, foreign_key: true
    add_reference :vtubers, :frequency, foreign_key: true
    add_reference :vtubers, :content, foreign_key: true
  end
end
