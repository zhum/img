#require "sqlite3"
require 'rom-sql'


module Img
  module SQLProxy
    def by_field(arr)
      warn "    sql-by-field Array: #{arr.inspect}"
      #warn "HASH: #{hash.inspect} (#{hash.class})"
      # warn "Data: #{users.call.inspect}"
      if arr.is_a? Hash
        result = self
        arr.each{|k,v|
          result = result.where(k.to_sym => v)
        }
        #x = {arr[0].keys[0].to_sym => arr[0].values[0]}
        #warn "    ** #{x}"
        #restrict(x) #field.to_sym => value)
        result

      # if arr[0].is_a? Hash
      #   x={arr[0].keys[0].to_sym => arr[0].values[0]} #field.to_sym => value)
      #   #warn  "   ** #{x}"
      #   where(x) #field.to_sym => value)
      else
        where arr[0].to_sym => arr[1]
      end
    end

  end
end
