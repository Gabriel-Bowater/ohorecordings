class AlbumsController < ApplicationController
  
	# validates_attachment_content_type :mp3

  def show
    @album = Album.find(params[:id])
    @tracks = Track.where(album_id: @album.id).order(:track_number)
  end

	def new
		@album = Album.new
	end

	def destroy
		@album = Album.find(params[:id])
		@album.destroy
		flash.notice = "Album #{@album.name} deleted. "
		redirect_to "/"
	end

	def create
		new_album = Album.new( album_params )
		if new_album.save!
			flash.notice = "New Album Created."
		else
			flash.alert = "Album failed to save. Name is the only essential, non-duplicatable field. Is there already an album by that name? check <a href='/albums/index'>here</a>"
		end
		
		redirect_to new_album_path

	end

	private 

	def album_params
    params.require(:album).permit(:name, :art_url, :year, 
    														:description, :artists, :isrc, 
    														:price, :mp3, :alac, 
    														:aac, :ogg, :flac)
  end
	
end
