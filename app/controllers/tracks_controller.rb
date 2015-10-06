class TracksController < ApplicationController

	def new
		@albums = Album.all
		@track = Track.new
	end

	def index
		if @user && @admins.include?(@user.email)
			@tracks = Track.all.order(:album_id)
		else
			redirect_to "/"
		end
	end

	def destroy
		@track = Track.find(params[:id])
		@track.destroy
		flash.notice = "Track #{@track.name} deleted. "
		redirect_to tracks_path

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
	end

	private 

	def track_params
    params.require(:track).permit(:name, :album_id, :track_number,
    							 :price, :track_isrc, :mp3, :alac, 
    							 :aac, :ogg, :flac, 
    							 :sample, :sample_url)
  end
	
end

