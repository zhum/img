require 'rom-yaml'
require 'rom-repository'


module Img
  module YAMLProxy
    def by_field(arr)
      warn "    yaml-by-field Array: #{arr.inspect} / #{arr[0]}"
      if arr.is_a? Hash
        result = self
        arr.each{|k,v|
          result = result.restrict(k.to_sym => v)
        }
        #x = {arr[0].keys[0].to_sym => arr[0].values[0]}
        #warn "    ** #{x}"
        #restrict(x) #field.to_sym => value)
        result
      else
        restrict(arr[0].to_sym => arr[1])
      end
#      restrict(field.to_sym => value)
    end
  end
end
