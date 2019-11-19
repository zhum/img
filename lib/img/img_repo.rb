module Img
  module Img_repo_mod
    def filter(cond)
      myname=name.to_s
      warn "where COND=#{cond.inspect} (#{myname.inspect})"
      field=cond.keys[0].to_s
      value=cond[cond.keys[0]]
      relations = Img.relations[myname] || {}
      warn "--> #{relations.keys} / #{field}"
      # field => value  = search condition

      if relations.has_key? field
        warn "!! #{relations[field]}"
        rel=relations[field]
        new_repo=Img.data(rel['table'])
        list=[]
        collected_data=nil

        # search in another table!!!
        # rel       = description of another table
        # new_repo  = new repository
        case rel['type']
        when :belongs_to
          ext_key=rel['key']#Img::Img.config['tables'][@name][]]
          my_key=rel['my_field']
          warn "  BELONGS_TO name=#{@name}; condition=#{value} ext_key=#{ext_key.inspect}"
          keys=[]
          new_repo.filter(value).each do |second_data|
            warn "... name=#{@name}; condition=#{value} data=#{second_data}"
            key = second_data[ext_key]
            keys << key unless keys.include? key
          end
          warn "  Subrequest returns keys: #{keys.inspect}"
          item = by_field(ext_key => keys).dataset
          warn "  Item = #{item.inspect}"
          if collected_data.nil?
            collected_data = item
            warn "!!! #{collected_data.to_a}"
          else
            collected_data.join(item)
            warn "+++ #{collected_data.to_a}"
          end

            #$stderr.puts "--->RELATION(#{ext_key},#{my_key},#{key}) data=#{second_data} item=#{item.inspect}"
        when :has_many
          ext_key=rel['key']#Img::Img.config['tables'][@name][]]
          my_key=rel['my_field']
          warn "  HAS_MANY: name=#{@name}; condition=#{value} ext_key=#{ext_key} my_key=#{my_key}"
#          the_item=new_repo.where(value)
          keys=[]
          new_repo.filter(value).each do |second_data|
            key = second_data[my_key]
            warn "...  name=#{@name}; condition=#{value} data=#{second_data} key=#{key}"
            keys << key unless keys.include? key
          end
          warn "  Subrequest returned keys: #{keys.inspect}"
          item=by_field(my_key => keys).dataset
          if collected_data.nil?
            collected_data=item
            warn "!!  #{collected_data.to_a}"
          else
            collected_data.join(item)
            warn "++  #{collected_data.to_a}"
          end
        end
        collected_data
      else
        warn "  WHERE name=#{@name} field(#{field})=#{value}."
        by_field(field => value).dataset
      end
    end

    def all
      dataset
      # warn "++ #{self.relations.inspect} #{@name}"
      # x = get_attr(@name).with_path('/')
      # warn x.inspect
      # warn "---"
      # get_attr(@name).to_a
    end

    def init(n,rel)
      @@relations=rel
      @name=n
    end
  end
end