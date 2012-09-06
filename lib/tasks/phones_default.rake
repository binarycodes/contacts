namespace :seed do
  desc "update default contact for all users to false"
  task :phone_default => :environment do
    Phone.all(:conditions => {:default => nil}).each do |phone|
      phone.update_attribute(:default, false)
    end
  end
end
