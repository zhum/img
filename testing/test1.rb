#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'img'
require "pp"

Img::Img.init('schema.yml')
puts "-------------------------------------\n\n\n"

puts "-- Select boos.id=1 --"
pp Img::Img.data('boos').filter( :id => 1).to_a
#pp Img::Img.data('boos').filter( :email => 'Sincere@april.biz').to_a
pp Img::Img.data('boos').filter('tasks' => {:descr => 'task number 1'}).to_a


# puts "-- Select users.email='qwe' --"
# pp Img::Img.data('users').filter( :email => 'qwe').to_a

# puts "-- Select users.all --"
# pp Img::Img.data('users').all.to_a.inspect #.where('id' => 1).inspect

#puts "-- Select task.id=1 --"
#puts Img::Img.data('tasks').where('id' => 1).inspect

# puts "-- Select task.owner.id=1 --"
# pp Img::Img.data('tasks').filter( author_id: 1).to_a  #:owner => {:email => 'qwe'},


#!puts "-- Select task.owner.email='qwe' --"
#pp Img::Img.data('tasks').filter( :owner => {:email => 'asd'}).to_a
#pp Img::Img.data('tasks').filter( :owner => {:email => 'qwe'}).to_a

#! puts "-- Select users.tasks.desc='task number 1' --"
# pp Img::Img.data('users').filter('tasks' => {:descr => 'task number 1'}).to_a

#! puts "-- Select users.all --"
# #pp Img::Img.data('users').all.inspect #.where('id' => 1).inspect
# pp Img::Img.data('users').all.to_a #.where('id' => 1).inspect
# pp Img::Img.data('users').all.filter(:id => 1).to_a