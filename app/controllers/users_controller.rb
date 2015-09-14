class UsersController < ApplicationController

  def new
  end

  def show
    @user = User.find(session[:user_id]) #User.find(session[:user_id])
    @user_albums = []
    @user_tracks = []
    AlbumRight.where(user_id: @user.id).each do |right|
      @user_albums << Album.find(right.album_id)
    end
    TrackRight.where(user_id: @user.id).each do |right|
      @user_tacks << Track.find(right.track_id)
    end
  end

  def create
    @user = User.new(email: params[:email].downcase,
                      given_name: params[:given_name],
                      family_name: params[:family_name],
                      address_one: params[:address_one],
                      address_two: params[:address_two],
                      address_city: params[:address_city],
                      address_country: params[:address_country])
    @user.password = params[:password]
    @user.save!
    redirect_to '/'
  end

  # def login #needs to be moved to sessions controller
  #   @user = User.find_by_email(params[:email])
  #   if @user.password == params[:password]
  #     give_token
  #   else
  #     redirect_to '/'
  #   end
  # end

end
