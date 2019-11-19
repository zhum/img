#!/usr/bin/env ruby
#
require 'pp'

require "sqlite3"
require 'rom-sql'
require 'rom-yaml'


# class Users < ROM::Relation[:yaml]
#   schema do
#     attribute :id, Types::Int
#     # attribute :name, Types::String, null: false
#     # attribute :email, Types::String, null: false

#     primary_key :id
#   end

#   # def index
#   #   select { [name, int::count(id).as(:count)] }.group(:id)
#   #   # SELECT "name", COUNT("id") AS "count" ...
#   # end

#   # def by_id(id)
#   #   where(id: id)    
#   # end
# end

#class Tasks < ROM::Relation[:yaml]
#   schema do
#     attribute :id, Types::Int
#     attribute :author_id, Types::Int
#     attribute :name, Types::String, null: false
#     attribute :descr, Types::String, null: false

#     primary_key :id
#   end

#   def by_id(id)
#     restrict(id: id)
#   end
# end

# rom1 = ROM.container(:sql, 'sqlite://test.db') do |config|
#   config.register_relation(Users)
# end

# rom2 = ROM.container(:yaml, 'test.yml') do |config|
#   config.register_relation(Test) #Tasks)
# end

# users = rom2.relations[:test]
#tasks = rom2.relations[:tasks]

# tasks.each{|task|
#   author=users.by_id(task[:author_id]).one
#   puts "Task #{task}, Author: #{author}"
# }


# x=users.index
# puts x.inspect
# y=tasks.index #where( email: 'qwe')
# puts y.inspect

$img_classes={
#  'sql'  => Class.new(ROM::Relation[:sql])  do include SQLProxy; end,
#  'yaml' => Class.new(ROM::Relation[:yaml]) do end, #include YAMLProxy; end,
}
TYPES={
  'int' => ROM::Types::Int,
  'str' => ROM::Types::String,
}


# class Test < ROM::Relation[:yaml]
#   schema do
#     attribute :id, ROM::Types::Int
#     primary_key :id
#   end
# end

rom3=ROM.container('yaml'.to_sym, 'test.yml') do |config|
  klass=Class.new(ROM::Relation[:yaml]) do
    schema do 
      attribute :id, ROM::Types::Int
    end
  end
  config.register_relation(klass)
end
