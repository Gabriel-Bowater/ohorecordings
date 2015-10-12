class UsersController < ApplicationController

  def new
  end

  def show
    if params[:mp3_album_id]
      album = Album.find(params[:mp3_album_id])
      link = album.mp3.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:ogg_album_id]
      album = Album.find(params[:ogg_album_id])
      link = album.ogg.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:aac_album_id]
      album = Album.find(params[:aac_album_id])
      link = album.aac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:alac_album_id]
      album = Album.find(params[:alac_album_id])
      link = album.alac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:flac_album_id]
      album = Album.find(params[:flac_album_id])
      link = album.flac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:mp3_track_id]
      track = Track.find(params[:mp3_track_id])
      link = track.mp3.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:ogg_track_id]
      track = Track.find(params[:ogg_track_id])
      link = track.ogg.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:aac_track_id]
      track = Track.find(params[:aac_track_id])
      link = track.aac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:alac_track_id]
      track = Track.find(params[:alac_track_id])
      link = track.alac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
    elsif params[:flac_track_id]
      track = Track.find(params[:flac_track_id])
      link = track.flac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
      flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe                 
    end

    @user = User.find(session[:user_id]) #User.find(session[:user_id])
    @user_albums = []
    @user_tracks = []
    AlbumRight.where(user_id: @user.id).each do |right|
      @user_albums << Album.find(right.album_id)
    end
    TrackRight.where(user_id: @user.id).each do |right|
      @user_tracks << Track.find(right.track_id)
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



end
