class AlbumsController < ApplicationController
  
	# validates_attachment_content_type :mp3

  def show
    @album = Album.find(params[:id])
    @tracks = Track.where(album_id: @album.id).order(:track_number)
  	@formats = Array.new
  	@formats << "mp3" if @album.mp3_file_name
  	@formats << "ogg" if @album.ogg_file_name
  	@formats << "alac" if @album.alac_file_name
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
		@album_rights = AlbumRight.where(album_id: @album.id)
		@album_orders = AlbumOrder.where(album_id: @album.id)
		@album.destroy
		@tracks.each do |track|
			track.destroy
		end
		@album_rights.each do |album_right|
			album_right.destroy
		end
		@album_orders.each do |album_order|
			album_order.destroy
		end		
		flash.notice = "Album #{@album.name} deleted. All tracks and album rights associated with this album have also been deleted."
		redirect_to "/"
	end

	def create
		new_album = Album.new( album_params )
		if new_album.save!
			flash.notice = "New Album Created. Add .zip or .rar archives to the album from the album page."
		else
			flash.alert = "Album failed to save. Name is the only essential, non-duplicatable field. Is there already an album by that name? check <a href='/albums/index'>here</a>"
		end
		
		redirect_to new_album_path
	end

	def update
		album = Album.find(params[:id])
		if params[:delete]
			if params[:delete] == "mp3"
				album.mp3 = nil
				album.save
			end
			if params[:delete] == "alac"
				album.alac = nil
				album.save
			end		
			if params[:delete] == "aac"
				album.aac = nil
				album.save
			end				
			if params[:delete] == "flac"
				album.flac = nil
				album.save
			end			
			if params[:delete] == "wav"
				album.wav = nil
				album.save
			end			
			redirect_to "/albums/#{params[:id]}"	
		else 
			album.update( album_params )
			album.save
			render nothing: true
		end
	end

	def upload
		@album = Album.find(params[:album_id])
		@format = params[:format]
	end

	private 

	def album_params
    params.require(:album).permit(:name, :art_url, :year, 
    														:description, :artists, :isrc, 
    														:price, :mp3, :alac, :wav,
    														:aac, :ogg, :flac)
  end
	
end
