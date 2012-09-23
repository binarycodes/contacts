class Contact < ActiveRecord::Base
  has_many :phones, :dependent => :destroy
  validates :phones, :presence => true
  attr_accessible :first_name, :last_name,  :remarks, :phones_attributes
  accepts_nested_attributes_for :phones, :allow_destroy => true

  normalize_attributes :first_name, :last_name, :remarks

  validates :first_name, :presence => true
  validates :first_name, :format => { :with => /\A[a-zA-Z ]+\Z/, :message => "can have only alphabets and space" }
  validates :first_name, :length => { :minimum => 2, :maximum => 50 }


  def full_name
    name = first_name
    name += " #{last_name}" unless last_name.nil?
    name
  end

  def self.search(search_param, sort_key, sort_dir)
    if search_param and not search_param.empty?
      Contact.joins(:phones).
        find(:all,
             :conditions => ['lower(contacts.first_name||contacts.last_name)||phones.phone_no LIKE ?', "%#{search_param.downcase}%"],
             :include => :phones,
             :order => "#{sort_key} #{sort_dir}");
    end
  end

end
