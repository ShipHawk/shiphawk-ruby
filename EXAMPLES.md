# Shiphawk::Client Gem Examples

## API Keys

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
