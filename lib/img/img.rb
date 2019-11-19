require 'yaml'
require 'rom-repository'

module Img

  class Img

    # database types
    TYPES={
      'int' => ROM::Types::Integer,
      'str' => ROM::Types::String,
    }

    # map data sources with ROM::Relations
    @@img_classes={
      'sql'  => Class.new(ROM::Relation[:sql])  do include SQLProxy; end,
      'yaml' => Class.new(ROM::Relation[:yaml]) do include YAMLProxy; end,
      'http' => Class.new(ROM::Relation[:http]) do include HTTPProxy; end,
    }

    @@img_proxies={
      'sql'  => SQLProxy,
      'yaml' => YAMLProxy,
      'http' => HTTPProxy,
    }

    def self.init(path)
      @@config=YAML::load IO::read(path)
      @@roms={}
      @@relations={}
      @@repos={}
      @@options={}
      @@config['tables'].each do |name,table|
        rel = Class.new(ROM::Relation[table['driver'].to_sym]) do
          schema(name.to_sym) do
            table['schema'].map { |k,v|
              $stderr.puts "attr #{name}: #{k.to_sym}, #{TYPES[v]}"
              attribute k.to_sym, TYPES[v]
            }
          end

          include @@img_proxies[table['driver']]
          #@myname=name
          include Img_repo_mod
          #@@relations[name]=table['relations']
        end

        configuration = ROM::Configuration.new(table['driver'].to_sym, table['location'])
        configuration.register_relation(rel)
        @@roms[name] = ROM.container(configuration)
      
        @@relations[name] = table['relations']
        @@options[name] = table['options'] || {}
        #x=@@roms[name].relations[:users].by_id(1)

        # @@roms[name] = ROM.container(table['driver'].to_sym) do |config|
        #   klass=Class.new(@@img_classes[table['driver']]) do
        #     schema(name.to_sym) do 
        #       table['schema'].map { |k,v|
        #         $stderr.puts "attr #{name}: #{k.to_sym}, #{TYPES[v]}"
        #         attribute k.to_sym, TYPES[v]
        #       }
        #     end
        #   end
        #   config.register_relation(klass)
        # end
        #warn "::#{name}:: #{@@roms[name].inspect}"
        warn "::#{name}:: "
        # repo=Class.new(ROM::Repository[name.to_sym]) do
        #   include Img_repo_mod
        #   @myname=name
        #   @relations[name]=table['relations']
        # end
        # @@repos[name]=repo.new(@@roms[name])
        # @@repos[name].init(name,table['relations'])
      end
    end

    def self.relations
      @@relations
    end

    def self.options
      warn "opts=#{@@options.inspect}"
      @@options
    end

    def self.relation(k)
      @@relations[k]
    end

    def self.data(name)
      warn "+++> #{name}"
      r = @@roms[name].relations[name]
      #r=@@repos[name]
      warn "!==> #{r.inspect} "#(#{r.to_a})"
      r
    end

    def self.config
      @@config
    end
  end
end
