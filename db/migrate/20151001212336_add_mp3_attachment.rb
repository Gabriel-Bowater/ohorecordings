class AddMp3Attachment < ActiveRecord::Migration
  def up
  	add_attachment :albums, :mp3
  end
  
  def down
  	remove_attachment :albums, :mp3
  end

end
