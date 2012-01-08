require 'net/http'

class ProxyChecker

  def self.blocked? url
    response = Net::HTTP.get(URI('http://'+url))
    response =~ /blocked/ ? false : true
  end

end