class AddAttachmentWavToAlbums < ActiveRecord::Migration
  def self.up
    change_table :albums do |t|
      t.attachment :wav
    end
  end

  def self.down
    remove_attachment :albums, :wav
  end
end
