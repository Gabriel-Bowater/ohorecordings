class AlbumOrder < ActiveRecord::Base
	belongs_to :order
	belongs_to :album
end