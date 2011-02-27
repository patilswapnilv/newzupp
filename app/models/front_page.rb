class FrontPage < ActiveRecord::Base

  #Associations
  has_many :front_page_stories
  has_many :stories, :through => :front_page_stories, :include => :site

  default_scope :order => "created_at desc"

end

