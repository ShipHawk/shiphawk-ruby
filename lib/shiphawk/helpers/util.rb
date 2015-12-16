module ShipHawk
  module Util
    extend self
    def objects_to_ids(obj)
      case obj
        when ShipHawk::Resource
          return {:id => obj.id}
        when Hash
          result = {}
          obj.each { |k, v| result[k] = objects_to_ids(v) unless v.nil? }
          puts result
          result
        when Array
          obj.map { |v| objects_to_ids(v) }
        else
          obj
      end
    end

    def convert_to_ShipHawk_object(response, api_key, parent=nil, name=nil)

      case response
        when Array
          response.map { |i| convert_to_ShipHawk_object(i, api_key, parent) }
        when Hash
          ShipHawk::ShipHawkObject.construct_from(response, api_key, parent, name)
        else
          response
      end
    end

    def symbolize_names(obj)
      case obj
        when Hash
          result = {}
          obj.each do |k, v|
            k = (k.to_sym rescue k) || k
            obj[k] = symbolize_names(v)
          end
          result
        when Array
          obj.map { |v| symbolize_names(v) }
        else
          obj
      end
    end

    def url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def flatten_params(params, parent_key=nil)
      result = []
      if params.is_a?(Hash)
        params.each do |k, v|
          calculated_key = parent_key ? "#{parent_key}[#{url_encode(k)}]" : url_encode(k)
          if v.is_a?(Hash) or v.is_a?(Array)
            result += flatten_params(v, calculated_key)
          else
            result << [calculated_key, v]
          end
        end
      elsif params.is_a?(Array)
        params.each_with_index do |v, i|
          calculated_key = parent_key ? "#{parent_key}[#{i}]" : i
          if v.is_a?(Hash) or v.is_a?(Array)
            result += flatten_params(v, calculated_key)
          else
            result << [calculated_key, v]
          end
        end
      end
      result
    end
  end
end

