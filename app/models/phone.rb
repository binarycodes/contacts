class Phone < ActiveRecord::Base
  PHONE_TYPES =["Mobile","Fixed Line"]

  belongs_to :contact, :validate => true

  validates :phone_no, :presence => true
  validates :phone_no, :format => { :with => /\A[+0-9]+\Z/, :message => "is not valid" }
  validates :phone_no, :length => { :minimum => 10, :maximum => 15 }
  
  validates :phone_type, :presence => true
  validates :phone_type, :inclusion => { :in => PHONE_TYPES }


  validates_uniqueness_of :phone_no

end
