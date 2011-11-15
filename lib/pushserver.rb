require 'uri'
require 'rubygems'
require 'active_support/core_ext/module/attribute_accessors'
module PushServer
  # default url and pushtest values
  mattr_accessor :uri
  mattr_accessor :appId
  @@uri = 'http://184.72.174.245/pushservice.php'
  @@appId = 'pushtest'

  def self.sendPushToUser(metadata)
    require 'net/http'
    require 'json'

    url = URI.parse(@@uri)
    # json data
    if metadata['appId'].nil?
      metadata['appId'] = @@appId
    end
    metadata['m'] = 'push'
    metadatajson = JSON.unparse(metadata) 
    json_data = {'metadata'=>metadatajson}

    # Send out the request. This is where the magic begins
    req = Net::HTTP::Post.new(url.path)
    req.add_field("X-Ypc-PushAuth", "super-secret-x")
    req.set_form_data(json_data)
    res = Net::HTTP.new(url.host, url.port).start do |http|
      http.request(req)
    end

    # status 200 means we did send a push notificaiton
    # status 100 means we didn't send a push notification
    # TODO: In the future, Push Notification Server will return status 400 for false, and status 500 for some exception. Change accordingly
    if res.body.include? "code\":200"
      return true
    elsif res.body.include? "code\":100"
      return false
    else
      raise res.body
    end
  end
end
