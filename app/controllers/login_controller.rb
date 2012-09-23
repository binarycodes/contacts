class LoginController < ApplicationController
  def create
    if params[:password]=="foo"
      session[:admin] = true
      flash[:notice] = "Successfully logged in"
    else
      flash[:error] = "Incorrect password"
    end
    redirect_to contacts_path
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to contacts_path
  end
end
