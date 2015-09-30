class AlbumsController < ApplicationController
  
  def show
    @album = Album.find(params[:id])
    @tracks = Track.where(album_id: @album.id).order(:track_number)
  end

	def new
		@admins = ["gd.bowater@gmail.com", "davebow@netaccess.co.nz"]
	end

	def create
		new_album = Album.new(name: params[:name],
													art_url: params[:art_url],
													artists: params[:artists],
													description: params[:description],
													flac_arch_url: params[:flac_arch_url],
													mp3_arch_url: params[:mp3_arch_url],
													aac_arch_url: params[:aac_arch_url],
													ogg_arch_url: params[:ogg_arch_url],
													alac_arch_url: params[:alac_arch_url],
													year: params[:year],
													price: params[:price],
													isrc: params[:isrc])
		if new_album.save!
			flash.notice = "New Album Created."
		else
			flash.alert = "Album failed to save. Name is the only essential, non-duplicatable field. Is there already an album by that name? check <a href='/albums/index'>here</a>"
		end
		
		redirect_to new_album_path
	end
	
end
