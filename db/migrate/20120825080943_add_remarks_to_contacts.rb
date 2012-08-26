class AddRemarksToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :remarks, :string

  end
end
