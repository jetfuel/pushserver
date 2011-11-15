#!/usr/local/bin/ruby
require 'rubygems'
require 'pushserver'

PushServer.appId = "pushtest"
PushServer.uri = 'http://184.72.174.245/pushservice.php'

metadata = { 
           'uid'=> 'jeffwang@atti.com',
           'alert' => 'This is a test push message'}
begin
  result = PushServer.sendPushToUser(metadata)
  if result == true
    puts "Yes, at least a push notification is sent"
  elsif result == false
    puts "No, need to send SMS"
  end
rescue => ex
  puts ex.message
end
