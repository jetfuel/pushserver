require 'helper'
require 'rubygems'
require 'pushserver'
require 'active_support/core_ext/module/attribute_accessors'

class TestPushserver < Test::Unit::TestCase
  should "get true from sendPushToUser" do
    PushServer.uri = 'http://184.72.174.245/pushservice.php'
    PushServer.appId = 'pushtest'

    assert !PushServer.sendPushToUser("doh@atti.com", "This is new message")
    assert PushServer.sendPushToUser("jeffwang@atti.com", "This is new message")
  end

  should "get false from sendPushToUser if misconfig" do
    PushServer.appId = 'push'
    PushServer.uri = 'http://184.72.174.245/pushservice.php'
    assert !PushServer.sendPushToUser("jeffwang@atti.com", "I shall not receive this message")
    puts PushServer.appId
  end

  should "be able to set url" do
    PushServer.uri = "http://badurl.invalid.php"
  end
  should "be able to set appid" do
    PushServer.appId = "push push"
  end
end
