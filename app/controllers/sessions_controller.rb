class SessionsController < ApplicationController

  def create
    session[:id] = 1
    redirect_to '/'
  end

  def destroy
    session[:id] = nil
    redirect_to '/'
  end
end
