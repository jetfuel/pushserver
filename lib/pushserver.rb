require 'uri'
module PushServer
  # default url and pushtest values
  @url = URI.parse('http://184.72.174.245/pushservice.php')
  @appId = 'pushtest'

  # set uri
  def self.setURI(url)
    @url = URI.parse(url)
  end

  # set app Id
  def self.setAppId(appId)
    @appId = appId
  end

  def self.sendPushToUser(uid, alert)
    require 'net/http'
    require 'json'

    puts @url
  
    # json data
    metadata = JSON.unparse({ 
                'm' => 'push',
                'appId' => @appId,
                'uid'=>uid,
                'delayWhileIdle' => 1,
                'badge' => 0,
                'alert' => alert})
    json_data = {'metadata'=>metadata}

    # Send out the request. This is where the magic begins
    req = Net::HTTP::Post.new(@url.path)
    req.add_field("X-Ypc-PushAuth", "super-secret-x")
    req.set_form_data(json_data)
    res = Net::HTTP.new(@url.host, @url.port).start do |http|
      http.request(req)
    end
 
    if res.body.include? "code\":200"
      return true
    else
      return false
    end
  end
end
