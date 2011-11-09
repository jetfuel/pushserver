#!/usr/local/bin/ruby

require 'rubygems'
require 'pushserver'
require 'json'

PushServer.appId = "pushtest"
PushServer.uri = 'http://184.72.174.245/pushservice.php'
if PushServer.sendPushToUser("jeffwang@atti.com", "This is my new message")
  puts "YES"
else
  puts "No, need to send SMS"
end
