#!/usr/local/bin/ruby

require 'rubygems'
require 'pushserver'
require 'json'

PushServer.setAppId("pushtest")

if PushServer.sendPushToUser("jeffwang@atti.com", "This is my new message")
  puts "YES"
else
  puts "No, need to send SMS"
end
