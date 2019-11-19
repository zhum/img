require 'rom'
require 'rom-http'

if false
module ROM
  module HTTPAdapter
    class Dataset < ROM::HTTP::Dataset
      config.default_request_handler = ->(dataset) do
        uri = dataset.uri

        http = Net::HTTP.new(uri.host, uri.port)
        inflector=Dry::Inflector.new
        request_klass = Net::HTTP.const_get(inflector.classify(dataset.request_method))

        request = request_klass.new(uri.request_uri)
        
        dataset.headers.each_with_object(request) do |(header, value), request|
          request[header.to_s] = value
        end

        response = http.request(request)
      end

      config.default_response_handler = ->(response, dataset) do
        if %i(post put patch).include?(dataset.request_method)
          JSON.parse(response.body, symbolize_names: true)
        else
          Array([JSON.parse(response.body, symbolize_names: true)]).flatten
        end
      end
    end

    class Gateway < ROM::HTTP::Gateway
      private
      def uri
        config.fetch(:uri) { fail Error, '+uri+ configuration missing' }
      end
    end

    class Relation < ROM::HTTP::Relation
      adapter :imghttp
    end

    module Commands
      class Create < ROM::HTTP::Commands::Create
        adapter :imghttp
      end

      class Update < ROM::HTTP::Commands::Update
        adapter :imghttp
      end

      class Delete < ROM::HTTP::Commands::Delete
        adapter :imghttp
      end
    end
  end
end

ROM.register_adapter(:imghttp, ROM::HTTPAdapter)
end
# configuration = ROM::Configuration.new(:http, {
#   uri: 'http://jsonplaceholder.typicode.com',
#   headers: {
#     Accept: 'application/json'
#   }
# })

# class Users < ROM::Relation[:http]
#   schema(:users) do
#     attribute :id, ROM::Types::Integer
#     attribute :name, ROM::Types::String
#     attribute :username, ROM::Types::String
#     attribute :email, ROM::Types::String
#     attribute :phone, ROM::Types::String
#     attribute :website, ROM::Types::String
#   end

#   def by_id(id)
#     with_path(id.to_s)
#   end
# end

# configuration.register_relation(Users)

# container = ROM.container(configuration)

# puts container.relations[:users].by_id(1).to_a
# #=> GET http://jsonplaceholder.typicode.com/users/1 [ Accept: application/json ]

module Img
  module HTTPProxy
    def by_field(arr)
      warn "    http-by-field Array: #{arr.inspect}"
      http_name = Img.options[name.to_s].fetch('name',name)
      result = with_base_path("/#{http_name}")
      if arr.is_a? Hash
        arr.each{|k,v|
          result = result.with_params(k.to_sym => v)
        }
        #x = {arr[0].keys[0].to_sym => arr[0].values[0]}
        #warn "    ** #{x}"
        #restrict(x) #field.to_sym => value)
        result
      # if arr[0].is_a? Hash
      #   with_base_path("/#{http_name}").with_params(arr[0].keys[0] => arr[0].values[0]) #field.to_sym => value)
      else
        append_path(arr[0].to_sym => arr[1])
      end
#      restrict(field.to_sym => value)
    end

    def get_attr(name)
      append_path(name)
    end
  end
end
