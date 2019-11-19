#!/usr/bin/env ruby

require "sqlite3"

require 'rom-sql'
require 'rom-yaml'


# class MyTest < ROM::Relation[:yaml]
#   schema do
#     attribute :id, ROM::Types::Int
#     primary_key :id
#   end
# end

# puts "Static test..."
# rom1=ROM.container(:yaml, 'test1.yml') do |config|
#   config.register_relation(MyTest)
# end
# puts "Passed."

puts "Dynamic test..."
rom2=ROM.container(:sql, 'sqlite://test.db') do |config|
  my_klass=Class.new(ROM::Relation[:sql]) do
    schema('users') do 
      attribute :id, ROM::Types::Integer
      primary_key :id
    end
  end
  config.register_relation(my_klass)
end
puts "Passed."

__END__
test1.yml = test2.yml

my_test:
  - id: 1
    text: qwe
  - id: 2
    text: asd
  - id: 3
    text: zxc
---------------------------
Gemfile

source 'https://rubygems.org'

gem 'rom'
gem 'rom-sql'
gem 'rom-yaml', '2.0.0.rc2'
gem 'sqlite3'
