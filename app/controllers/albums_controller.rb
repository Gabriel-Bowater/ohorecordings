class AlbumsController < ApplicationController
  
	# validates_attachment_content_type :mp3

  def show
    @album = Album.find(params[:id])
    @tracks = Track.where(album_id: @album.id).order(:track_number)
  	@formats = Array.new
  	@formats << "mp3" if @album.mp3_file_name
  	@formats << "ogg" if @album.ogg_file_name
  	@formats << "m4a" if @album.alac_file_name
  	@formats << "aac" if @album.aac_file_name
  	@formats << "flac" if @album.flac_file_name
  	@formats << "wav" if @album.wav_file_name
  end

	def new
		@album = Album.new
	end

	def destroy
		@album = Album.find(params[:id])
		@tracks = Track.where(album_id: @album.id)
		@album.destroy
		@tracks.each do |track|
			track.destroy
		end
		flash.notice = "Album #{@album.name} deleted. All tracks associated with this album have also been deleted."
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
    														:price, :mp3, :alac, :wav,
    														:aac, :ogg, :flac)
  end
	
end
