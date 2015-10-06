class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :user_cart_count 
  before_action :set_user_and_admins

  def set_user_and_admins
  	if session[:user_id]
  		@user = User.find(session[:user_id])
  	else
  		@user = nil
  	end
    @admins = ["gd.bowater@gmail.com", "davebow@netaccess.co.nz"]
  end

  def user_cart_count
  	@user_cart_count = 0
  	if Order.where(user_id: session[:user_id], completed: false)[0]
  	  @user_cart_count += AlbumOrder.where(order_id: Order.where(user_id: session[:user_id], completed: false)[0].id).length
  	  @user_cart_count +=TrackOrder.where(order_id: Order.where(user_id: session[:user_id], completed: false)[0].id).length
    end
  end
end
