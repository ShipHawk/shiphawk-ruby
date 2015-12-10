# Shiphawk::Client Gem Examples

## Client Initialization

To make a connection to a ShipHawk server, create a Client connection:

```ruby
    require 'rubygems'
    require 'shiphawk'

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

## Items retrieval and searching

### Item retrieval

Here's an example of retrieving an Item given the Item ID using the Shiphawk::Client API

```ruby
    require 'rubygems'
    require 'shiphawk'

    # get an item based on item id
    client = Shiphawk::Client.new(api_token: 'api_token')
    client.items_show 2335
```

## Notifications

```ruby
    require 'rubygems'
    require 'shiphawk'

    # get an item based on item id
    client = Shiphawk::Client.new(api_token: 'api_token')
```

## Products

```ruby
    require 'rubygems'
    require 'shiphawk'

    # get an item based on item id
    client = Shiphawk::Client.new(api_token: 'api_token')
```

## Rates

Get a shipping quote. Documentation here: https://shiphawk.com/api-docs#!/rates/POST_api_version_rates_format

Creating a quote
```ruby
    require 'rubygems'
    require 'shiphawk'

    client = Shiphawk::Client.new(api_token: 'api_token')

    custom_attributes = {
      value: declared_value_per_lot, quantity: lot_size, id: shiphawk_item_id,
      width: width, length: depth, height: height, packed: is_packed?,
      weight: shipping_weight_in_pounds, name: name, xid: barcode,
    }

    client.create_rate(data.merge(custom_attributes))

```

## Shipment Notes

Create customer note about a shipment

```ruby
    require 'rubygems'
    require 'shiphawk'

    Shiphawk.notes_update(shipment_id, {body: "This is a classy note"})
```

## Shipment Tracking

Subscribe to tracking notifications for a shipment.

```ruby
    require 'rubygems'
    require 'shiphawk'

    Shiphawk.shipments_status_update(shipment_id, {callback_url:  "www.someawesomecallback.com/shipment-tracking-callback/#{shipment_id}"})
```

## Shipments

Create a shipment

```ruby
    require 'rubygems'
    require 'shiphawk'

    data = {
      xid: buyer_invoice.to_s,
      rate_id: shiphawk_quote_id,
      destination_address:
      {
        first_name: user.first_name, last_name: user.last_name,
        company: name, phone_num: user.phone, email: user.email,
        address_line_1: address, address_line_2: floor_suite,
        city: city, state: state, zipcode: zip
      },
      billing_address: shiphawk_region_rep,
      origin_contact: shiphawk_region_rep,
      accessorials: [],
      order_email: shiphawk_region_rep[:email],
      pickup_data: pickup_data  
    }

    Shiphawk.shipments_create(data)
```

## Shipments Status

Update a number of shipments at once (need to confirm)

```ruby
    require 'rubygems'
    require 'shiphawk'
    Shiphawk.shipments_status_update({shipment_ids: [1,2,3], status: "in_transit"})
```

## Zip Codes

Get all zip codes using pagination.

```ruby
    require 'rubygems'
    require 'shiphawk'
    Shiphawk.zip_codes_index
```
