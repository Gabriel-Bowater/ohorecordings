class Track < ActiveRecord::Base
  belongs_to :album
  has_many :track_orders
  has_many :track_rights
end
