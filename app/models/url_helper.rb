module UrlHelper

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def create_hash(url)
      Digest::MD5.hexdigest(strip_url(url))
    end
  
    def strip_url(url)
      url.gsub(/http[s]?:\/\//, "")
    end
  end
  
  def get_http_response(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"User-Agent" => "Newzupp/2.0"})
    response = http.request(request)
    response.body
  end


end
