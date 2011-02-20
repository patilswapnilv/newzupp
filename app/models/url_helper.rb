module UrlHelper

  def create_hash(url)
    Digest::MD5.hexdigest(strip_url(url))
  end
  
  def strip_url(url)
    url.gsub(/http[s]?:\/\//, "")
  end

end
