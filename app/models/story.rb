class Story < ActiveRecord::Base

  # Associations
  belongs_to :site

  def self.find_or_create_story(site_id, site_name, url, title, score)
    url_hash = create_hash(url)
    story = Story.where(:site_id => site_id, :url_hash => url_hash).first
    if story.blank?
      story = Story.create( :site_id => site_id, :title => title,
                            :url => url, :url_hash => url_hash,
                            :site_name => site_name)
    end
    story.update_attribute(site_name, score.to_i)
  end

  def self.create_hash(url)
    Digest::MD5.hexdigest(strip_url(url))
  end
  
  def self.strip_url(url)
    url.gsub(/http[s]?:\/\//, "")
  end

end
