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
		@partner = check_for_partner(@album.name)

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
			redirect_to "/albums/#{params[:id]}"	
		end
	end

	def edit
		@album = Album.find(params[:id].to_i)
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

 	def check_for_partner album_name
 		if album_name.downcase.include?("hi-res")
 			album_name_substring = album_name.split(" ")[0..-2].join(" ")
 			if Album.where(["name LIKE?", "%#{album_name_substring}%"]).length == 2
 				Album.where(["name LIKE?", "%#{album_name_substring}%"]).each do |a|
 					if !a.name.downcase.include?("hi-res") && a.name.downcase.include?(album_name_substring.downcase)
 						return a
 					end
 				end
 			end
 		else
 			if Album.where(["name LIKE?", "%#{album_name}%"]).length == 2
 				Album.where(["name LIKE?", "%#{album_name}%"]).each do |a|
 					if a.name.downcase.include?("hi-res")
 						return a
 					end
 				end
 			end
 		end
 		return nil
 	end
	
end
