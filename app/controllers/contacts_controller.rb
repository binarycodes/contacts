class ContactsController < ApplicationController
  respond_to :html, :js, :json
  helper_method :sort_column, :sort_direction

  def index
    @contacts = Contact.includes(:phones).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def new
    @contact = Contact.new
    1.times { @contact.phones.build }
  end

  def show
    @contact = Contact.find(params[:id])
    session[:last_page] = request.env['HTTP_REFERER'] || contacts_path
  end

  def edit
    @contact = Contact.find(params[:id])
    session[:last_page] = request.env['HTTP_REFERER'] || contacts_path
  end

  def update
    contact = Contact.find params[:id]
    contact.attributes = params[:contact]
    if contact.save
      session[:last_page] = request.env['HTTP_REFERER'] || contacts_path
      redirect_to contact_path, :notice => "Your contact has been successfully updated"
    else
      redirect_to :back, :alert => "There was an error updating your contact"
    end
  end

  def create
    @contact = Contact.new params[:contact]
    if @contact.save
      session[:last_page] = request.env['HTTP_REFERER'] || contacts_path
      redirect_to contact_path(@contact), :notice => "New Contact successfully added"
    else
      render :action => :new
    end
  end

  def destroy
    Contact.destroy params[:id]
    redirect_to contacts_path, :notice => "Contact has been deleted"
  end

  private

  def sort_column
    (Contact.column_names.include? params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    (%w[asc desc].include? params[:direction]) ? params[:direction] : "asc"
  end
end
