class ReplaceUrlColumnsForFilesAlbum < ActiveRecord::Migration
  def up
  	add_attachment :albums, :alac
  	add_attachment :albums, :aac
  	add_attachment :albums, :ogg
  	add_attachment :albums, :flac

  	remove_column :albums, :mp3_arch_url
  	remove_column :albums, :alac_arch_url
  	remove_column :albums, :aac_arch_url
  	remove_column :albums, :ogg_arch_url
  	remove_column :albums, :flac_arch_url


  end

  def down
  	remove_attachment :albums, :alac
  	remove_attachment :albums, :aac
  	remove_attachment :albums, :ogg
  	remove_attachment :albums, :flac

  	add_column :albums, :mp3_arch_url, :string
  	add_column :albums, :alac_arch_url, :string
  	add_column :albums, :aac_arch_url, :string
  	add_column :albums, :ogg_arch_url, :string
  	add_column :albums, :flac_arch_url, :string

  end
end
