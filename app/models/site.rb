class Site < ActiveRecord::Base
  
  # Validations
  validate :name, :presence => true
  validate :url, :presence => true
  validate :shortname, :presence => true
end
