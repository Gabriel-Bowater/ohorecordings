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

	def update
		track = Track.find(params[:id])
		if params[:delete]
			if params[:delete] == "mp3"
				track.mp3 = nil
				track.save
			end
			if params[:delete] == "alac"
				track.alac = nil
				track.save
			end		
			if params[:delete] == "aac"
				track.aac = nil
				track.save
			end				
			if params[:delete] == "flac"
				track.flac = nil
				track.save
			end			
			if params[:delete] == "wav"
				track.wav = nil
				track.save
			end
			redirect_to "/tracks/#{params[:id]}"
		else 
			track.update( track_params )
			track.save
			render nothing: true
		end
	end
	
	def upload
		@track = Track.find(params[:track_id])
		@format = params[:format]
	end

	def destroy
		@track = Track.find(params[:id])
		@track.destroy
		@track_rights = TrackRight.where(track_id: @track.id)
		@track_orders = TrackOrder.where(track_id: @track.id)
		@track_rights.each do |track_right|
			t_r.destroy
		end
		@track_orders.each do |track_order|
			track_order.destroy
		end		
		flash.notice = "Track #{@track.name} deleted. "
		redirect_to tracks_path
	end

	def create
		if params[:track][:track_number] = ""
			params[:track][:track_number] = Track.where(album_id: params[:track][:album_id]).length + 1
		end
		new_track = Track.new( track_params )
		if new_track.save!
			flash.notice = "New Track Created. Click the  file icon next to the track to upload audio formats."
		else
			flash.alert = "Track failed to save. Name is the only essential, non-duplicatable field. Is there already an track by that name? check <a href='/tracks/index'>here</a>"
		end
		
		redirect_to album_path(params[:track][:album_id])
	end

	def show
		if !(@user && @admins.include?(@user.email))
			redirect_to '/'
		elsif !@user
			redirect_to '/'
		end
		@track = Track.find(params[:id])
		@formats = Array.new
  	@formats << "mp3" if @track.mp3_file_name
  	@formats << "ogg" if @track.ogg_file_name
  	@formats << "alac" if @track.alac_file_name
  	@formats << "aac" if @track.aac_file_name
  	@formats << "flac" if @track.flac_file_name
  	@formats << "wav" if @track.wav_file_name
	end

	private 

	def track_params
    params.require(:track).permit(:name, :album_id, :track_number,
    							 :price, :track_isrc, :mp3, :alac, 
    							 :aac, :ogg, :flac, :wav, 
    							 :sample, :sample_url)
  end
	
end

