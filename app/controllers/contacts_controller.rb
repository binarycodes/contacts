class ContactsController < ApplicationController
  respond_to :html, :js

  def index
    @contacts = Contact.search(params[:search])
  end

  def new
    @contact = Contact.new
    2.times { @contact.phones.build }
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def edit
    @contact = Contact.find params[:id]
  end

  def update
    contact = Contact.find params[:id]
    contact.attributes = params[:contact]
    if contact.save
      redirect_to contacts_path, :notice => "Your contact has been successfully updated"
    else
      redirect_to :back, :alert => "There was an error updating your contact"
    end
  end

  def create
    @contact = Contact.new params[:contact]
    if @contact.save
      redirect_to contacts_path, :notice => "New Contact successfully added"
    else
      render :action => :new
    end
  end

  def destroy
    Contact.destroy params[:id]
    redirect_to contacts_path, :notice => "Contact has been deleted"
  end
end
