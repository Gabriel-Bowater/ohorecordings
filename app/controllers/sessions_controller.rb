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
	      response = "Bad Password. Bad!"
	    end
	  else
	  	response = "User not found"
  	end
  	if response
			render text: response
		else
			redirect_to '/'
		end

  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
