module ShipHawk
  class Resource < ShipHawkObject
    def self.class_name
      camel = self.name.split('::')[-1]
      snake = camel[0..0] + camel[1..-1].gsub(/([A-Z])/, '_\1')
      return snake.downcase
    end

    def self.url
      if self.class_name == 'resource'
        raise NotImplementedError.new('Resource is an abstract class to perform generic actions on its subclasses (Address, Shipment, etc.)')
      end

      "/#{CGI.escape(self.class_name.downcase)}"
    end

    def url
      unless self.id
        raise Error.new("Could not determine which URL to request: #{self.class} instance has invalid ID: #{self.id.inspect}")
      end
      "#{self.class.url}/#{CGI.escape(id)}"
    end

    def refresh
      response, api_key = ShipHawk::ApiClient::request(:get, url, @api_key, @retrieve_options)
      refresh_from(response, api_key)
      self
    end

    def self.all(filters={}, api_key=nil)
      response, api_key = ShipHawk::ApiClient::request(:get, url, api_key, filters)
      ShipHawk::Util.convert_to_ShipHawk_object(response, api_key)
    end

    def self.find(id, api_key=nil)
      id = id.to_s
      instance = self.new(id, api_key)
      instance.refresh
      instance
    end

    def self.create(params={}, api_key=nil)
      wrapped_params = {}
      wrapped_params[self.class_name.to_sym] = params
      response, api_key = ShipHawk::ApiClient::request(:post, self.url, api_key, wrapped_params)
      ShipHawk::Util.convert_to_ShipHawk_object(response, api_key)
    end

  end
end
