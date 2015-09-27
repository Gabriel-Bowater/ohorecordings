class TracksController < ApplicationController

	def new
		@admins = ["gd.bowater@gmail.com", "davebow@netaccess.co.nz"]
		@albums = Album.all
	end

	def create
		if params[:track_number] != ""
			track_number = params[:track_number]
		else
			track_number = Track.where(album_id: params[:album_id]).length + 1
		end
		new_album = Track.new(name: params[:name],
								album_id: params[:album_id],
								track_number: track_number,
								flac_url: params[:flac_url],
								mp3_url: params[:mp3_url],
								aac_url: params[:aac_url],
								ogg_url: params[:ogg_url],
								alac_url: params[:alac_url],
								sample_url: params[:sample_url],
								price: params[:price],
								track_isrc: params[:track_isrc])
		if new_album.save!
			flash.notice = "New Track Created."
		else
			flash.alert = "Album failed to save. Name is the only essential, non-duplicatable field. Is there already an album by that name? check <a href='/albums/index'>here</a>"
		end
		
		redirect_to new_track_path
		
	end
	
end

# (id: integer, album_id: integer, name: string, track_number: integer, flac_url: string, mp3_url: string, aac_url: string, ogg_url: string, sample_url: string, description: string, price: decimal, track_isrc: string, created_at: datetime, updated_at: datetime