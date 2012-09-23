class LoginController < ApplicationController
  include LoginHelper

  def create
    if md5sum(params[:password])=="3858f62230ac3c915f300c664312c63f"
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
