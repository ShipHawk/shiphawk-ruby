# Shiphawk::Client Gem Examples

## Client Initialization

To make a connection to a ShipHawk server, create a Client connection:

```ruby
    require 'rubygems'
    require 'shiphawk-ruby'
    
    # get an item based on item id
    client = Shiphawk::Client.new(api_token: 'api_token')
```

Shiphawk::Client initialize takes a parameter hash to configure a connection. The parameters hash can consistent of:

```ruby
    PRODUCTION_API_HOST = 'https://shiphawk.com'
    DEFAULT_API_VERSION = 'v3'
    
    @api_token = @options.delete(:api_token) { |key| Shiphawk.api_token }
    @api_version = @options.delete(:api_version) { |key| DEFAULT_API_VERSION }
    @host_url = @options.delete(:host_url) { |key| PRODUCTION_API_HOST }
    @adapter = @options.delete(:adapter) { |key| Faraday.default_adapter }
```

## Item retrieval and searching

Here's an example of retrieving an Item given the Item ID using the Shiphawk::Client API

```ruby
    require 'rubygems'
    require 'shiphawk-ruby'
    
    # get an item based on item id
    client = Shiphawk::Client.new(api_token: 'api_token')
    client.items_show 2335
```

## Notifications

## Products

## Rates

## Shipment Notes

## Shipment Tracking

## Shipments

## Shipments Status

## Zip Codes
