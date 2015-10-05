class TracksController < ApplicationController

	def new
		@admins = ["gd.bowater@gmail.com", "davebow@netaccess.co.nz"]
		@albums = Album.all
		@track = Track.new
	end

	def create
		if params[:track][:track_number] = ""
			params[:track][:track_number] = Track.where(album_id: params[:track][:album_id]).length + 1
		end
		new_album = Track.new( track_params )
		if new_album.save!
			flash.notice = "New Track Created."
		else
			flash.alert = "Album failed to save. Name is the only essential, non-duplicatable field. Is there already an album by that name? check <a href='/albums/index'>here</a>"
		end
		
		redirect_to album_path(params[:track][:album_id])
		# render text: params[:track][:track_number]
	end

	private 

	def track_params
    params.require(:track).permit(:name, :album_id, :track_number,
    							 :price, :track_isrc, :mp3, :alac, 
    							 :aac, :ogg, :flac, 
    							 :sample, :sample_url)
  end
	
end

# (id: integer, album_id: integer, name: string, track_number: integer, flac_url: string, mp3_url: string, aac_url: string, ogg_url: string, sample_url: string, description: string, price: decimal, track_isrc: string, created_at: datetime, updated_at: datetime