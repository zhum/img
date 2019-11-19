require 'rom-yaml'
require 'rom-repository'


module Img
  module YAMLProxy
    def by_field(*arr)
      warn "    yaml-by-field Array: #{arr.inspect} / #{arr[0]}"
      if arr[0].is_a? Hash
        x = {arr[0].keys[0].to_sym => arr[0].values[0]}
        #warn "    ** #{x}"
        restrict(x) #field.to_sym => value)
      else
        restrict(arr[0].to_sym => arr[1])
      end
#      restrict(field.to_sym => value)
    end
  end
end
