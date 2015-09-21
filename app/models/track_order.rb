class TrackOrder < ActiveRecord::Base
	belongs_to :order
	belongs_to :track
end