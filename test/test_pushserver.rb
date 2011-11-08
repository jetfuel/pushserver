require 'helper'

class TestPushserver < Test::Unit::TestCase
  should "get true from sendPushToUser" do
    PushServer.setURI('http://184.72.174.245/pushservice.php')
    PushServer.setAppId('pushtest')

    assert !PushServer.sendPushToUser("doh@atti.com", "This is new message")
    assert PushServer.sendPushToUser("jeffwang@atti.com", "This is new message")

    PushServer.setAppId('push')
    assert !PushServer.sendPushToUser("jeffwang@atti.com", "This is new message")
  end

  should "be able to set url" do
    assert PushServer.setURI("http://badurl.invalid.php")
  end
  should "be able to set appid" do
    assert PushServer.setAppId("push push")
  end
end
