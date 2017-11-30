class ReplaceTrackUrlColumns < ActiveRecord::Migration
	def up
	
    add_attachment :tracks, :mp3
	add_attachment :tracks, :alac
  	add_attachment :tracks, :aac
  	add_attachment :tracks, :ogg
  	add_attachment :tracks, :flac
  	add_attachment :tracks, :sample

  	remove_column :tracks, :mp3_url 
  	remove_column :tracks, :alac_url 
  	remove_column :tracks, :aac_url 
  	remove_column :tracks, :ogg_url 
  	remove_column :tracks, :flac_url 

	end

	def down
    remove_attachment :tracks, :mp3
	remove_attachment :tracks, :alac
  	remove_attachment :tracks, :aac
  	remove_attachment :tracks, :ogg
  	remove_attachment :tracks, :flac
  	remove_attachment :tracks, :sample

  	add_column :tracks, :mp3_url, :string
  	add_column :tracks, :alac_url, :string
  	add_column :tracks, :aac_url, :string
  	add_column :tracks, :ogg_url, :string
  	add_column :tracks, :flac_url, :string
	end
end
