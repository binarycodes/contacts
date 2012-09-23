class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :admin?

  protected

  def authorize
    unless admin?
      flash[:error] = "unauthorized access"
      redirect_to contacts_path
      false
    end
  end

  def admin?
    session[:admin]==true
  end

  # private section
  private

  def sort_column
    (Contact.column_names.include? params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    (%w[asc desc].include? params[:direction]) ? params[:direction] : "asc"
  end

end
