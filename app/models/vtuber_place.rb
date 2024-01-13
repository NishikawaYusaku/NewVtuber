class VtuberPlace < ApplicationRecord
  belongs_to :vtuber
  belongs_to :place
end
