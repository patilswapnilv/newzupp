class Site < ActiveRecord::Base
  
  # Associations
  has_many :stories

  # Validations
  validate :name, :presence => true
  validate :url, :presence => true
  validate :shortname, :presence => true
end
