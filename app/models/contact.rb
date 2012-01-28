class Contact < ActiveRecord::Base
  has_many :phones, :dependent => :destroy
  validates_presence_of :phones

  accepts_nested_attributes_for :phones, :allow_destroy => true

  validates :first_name, :presence => true
  #validates :last_name, :presence => true

  validates :first_name, :format => { :with => /\A[a-zA-Z]+\Z/, :message => "can have only alphabets" }
  #validates :last_name, :format => { :with => /\A[a-zA-Z]+\Z/, :message => "can have only alphabets" }

  validates :first_name, :length => { :minimum => 2, :maximum => 30 }
  #validates :last_name, :length => { :minimum => 2, :maximum => 30 }


  def self.search(search)
    if search
      Contact.where("lower(first_name) LIKE :search OR lower(last_name) LIKE :search",
                    {:search => "%#{search.downcase}%"}).order("first_name ASC")
    else
      Contact.includes(:phones).order("first_name ASC")
    end
  end

end
