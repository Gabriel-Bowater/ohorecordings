class AddAttachmentWavToTracks < ActiveRecord::Migration
  def self.up
    change_table :tracks do |t|
      t.attachment :wav
    end
  end

  def self.down
    remove_attachment :tracks, :wav
  end
end
