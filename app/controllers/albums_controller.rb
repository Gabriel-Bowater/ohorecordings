class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    @tracks = Track.where(album_id: @album.id)
  end
end
