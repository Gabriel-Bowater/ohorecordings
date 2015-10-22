class Order < ActiveRecord::Base
  belongs_to :user
  has_many :album_orders
  has_many :track_orders
end
