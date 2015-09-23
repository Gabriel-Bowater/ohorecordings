class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :user_cart_count

  def index
  	@user = User.find(session[:user_id]) if session[:user_id]
  end

  def user_cart_count
  	@user_cart_count = 0
  	if Order.where(user_id: session[:user_id], completed: false)[0]
  	  @user_cart_count += AlbumOrder.where(order_id: Order.where(user_id: session[:user_id], completed: false)[0].id).length
  	  @user_cart_count +=TrackOrder.where(order_id: Order.where(user_id: session[:user_id], completed: false)[0].id).length
    end
  end
end
