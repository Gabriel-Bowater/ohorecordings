class SessionsController < ApplicationController

	def  new
		# render text: params
	end

  def create
    @user = User.find_by_email(params[:email])
    if @user
	    if @user.password == params[:password]
	      session[:user_id] = @user.id
	      # response = session[:user_id]
	    else
	      # redirect_to '/'
	      flash.alert = "Incorrect Password"
	    end
	  else
	  	flash.alert = "User not found"
  	end
	redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
