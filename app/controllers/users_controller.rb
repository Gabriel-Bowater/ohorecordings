class UsersController < ApplicationController

  def new
  end

  def show
    @user = session[:id] #User.find(session[:user_id])
  end

  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
    @user.save!
  end

  def login #needs to be moved to sessions controller
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      give_token
    else
      redirect_to '/'
    end
  end

end