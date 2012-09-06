class SearchController < ApplicationController
  respond_to :html, :js, :json
  helper_method :sort_column, :sort_direction

  def index
    if (params[:search].nil? or params[:search].empty?)
      redirect_to contacts_path
    else
      puts "here"
      @contacts = Contact.search(params[:search])
    end
  end

end
