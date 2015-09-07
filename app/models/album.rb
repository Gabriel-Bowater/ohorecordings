class Album < ActiveRecord::Base
  has_many :tracks
  has_many :album_rights
  has_many :album_orders
end
