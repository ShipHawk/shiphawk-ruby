# ShipHawk Ruby Client Library

**ShipHawk** is a powerful shipping API for managing all of your shipping data. We streamline the shipping process for you, making it easy to ship and manage everything from small parcel to freight to multi-palletized shipments. Through use of our client, you will gain insights into the business of shipping that will save your company and clients both time and money.

Our ruby gem provides an easy-to-use wrapper for ShipHawk's V3 REST APIs (note the new and improved V4 endpoints will be released shortly).

You can easily integrate many different shipping services into your business with this client (see example below). Please sign up for an account here at **https://shiphawk.com** to get your `api_key`.

**Note**: If you're not a developer, be sure to ask us about our **Dashboard**, a slick UI for organizing all your shipping data. We also offer a variety of shipping tools and widgets which can greatly simplify your company's shipping needs.

---

Installation
---------------

Install the gem:

```
gem install shiphawk
```

Import the ShipHawk client into your application by adding these lines:

```
require 'shipawk'
ShipHawk.configure.api_key =  'YOUR_API_KEY'
```
---



Example Usage
------------------

In the following example, we're going to make it easy for you to test and learn about our Ruby client and API endpoints. We'll be booking a shipment via the command line. Yes, it is entirely possible to get Rates, book and track your Shipments etc... from your console.

#### Step 1:  Clone the ShipHawk Ruby Client locally.

First we'll clone the shiphawk-ruby repo to our local machine. At the command line, type:


```
git clone -b development-branch --single-branch https://github.com/ShipHawk/shiphawk-ruby.git
cd shiphawk-ruby
bundle
```

You're now ready to enter the ShipHawk Interactive Ruby Shell. Type:

```ruby
shiphawk-irb
```
That's it. Now you have complete access to the ShipHawk API from your console. Well...almost. First you need to authorize your Ruby client.

#### Step 2:  Authorize your Client.
Copy and paste the line below into your console. Be sure to use the Api Key you were provided with.
```ruby
ShipHawk.configure.api_key = 'YOUR_PRODUCTION_API_KEY'

# Don't have an api key? Learn about our API in ShipHawk's Sandbox environment
ShipHawk.configure.api_key = '8b8f60ee7afe8f1f07161bbc7120f25a'

# Note: Once you've updated your Api Key to Sandbox, 
# you'll need to update your host to match the corresponding environment:

# to use the SandBox environment
ShipHawk.configure.host = ShipHawk.configure.sandbox

# and to switch back to Production:
ShipHawk.configure.api_key = 'YOUR_PRODUCTION_API_KEY'
ShipHawk.configure.host = ShipHawk.configure.production
```

Once you've authorized your Client, you can view your account Api Keys like this:
```ruby
api_keys = ShipHawk::ApiKeys.all
```
You can also configure the host, version, and your api_key at the same time:
```ruby
ShipHawk.configure do |config|
  config.api_key = '8b8f60ee7afe8f1f07161bbc7120f25a'
  config.host = 'sandbox.shiphawk.com'
  config.api_version = 'v3'
end
```

Don't have an Api Key? *( contact alex.hawkins@shiphawk.com for more information about obtaining one )*

#### Step 3:  Set the Origin and Destination Address

**Note**: Address and Parcel creation via our Ruby Client will be available with the release of **V4**. For now, let's just create an Address using our search endpoint.

```ruby
origin_address      = ShipHawk::Addresses.search(q: '90210').first['address']
destination_address = ShipHawk::Addresses.search(q: '92115').first['address']
```
**Special Note**: If you haven't added any addresses to your address book yet, you won't be able use our address search end point. You can create your addresses manually(see below). Once you've booked your shipment, each address(destination & origin) will be added to your address book and become searchable.
```ruby
destination_address = {
  "first_name"=>"Biff",
  "last_name"=>"Tannin", 
  "street1"=>"1955 Back to the Future St",
  "street2"=>nil,
  "city"=>"Hill Valley",
  "state"=>"CA",
  "zip"=>"95420",
  "phone_number"=>"510-265-2495",
  "email"=>"biff.tanning@shiphawk.com",
  "company"=>"Mr. Fujitsu. CusCo",
  "location_type"=>"commercial",
  "country"=>"US",
  "code"=>nil
}

origin_address = {
  "first_name"=>"Hans",
  "last_name"=>"Gruber", 
  "street1"=>"1988 Die Hard St",
  "street2"=>nil,
  "city"=>"Los Angeles",
  "state"=>"CA",
  "zip"=>"90064",
  "phone_number"=>"805-187-2495",
  "email"=>"hans.gruber@shiphawk.com",
  "company"=>"Nakatomi Plaza",
  "location_type"=>"residential",
  "country"=>"US",
  "code"=>nil
}

```

#### Step 4:  Create the Items we're Shipping

First create a container for storing all your items. We'll call this our `items_cart` and set it equal to an empty array like so:

```ruby
items_cart = []
```

Let's assume the item we're shipping is **unpacked**. Now we'll query ShipHawk's product database to find our unpacked item.

```ruby
all_sofas = ShipHawk::Items.search(:q => 'sofa')
all_rings = ShipHawk::Items.search(:q => 'ring')
```

For the sake of simplicity, we're only going to deal with 1 item here. And we're going to select the first item that is returned and save it to a variable called `sofa`.

```ruby
sofa = all_sofas.first
```

Next, we need to put our item in a format that the API can understand. To speed things up, here are two pre-populated item objects for you.

```ruby
big_sofa = {
    "id"=>"1234",
    "length"=>80.0,
    "width"=>80.0,
    "height"=>60.0,
    "weight"=>10.0,
    "packed"=>false,
    "value"=>10.0
    }

ring = {
    "id"=>"126",
    "length"=>1.0,
    "width"=>1.0,
    "height"=>1.0,
    "weight"=>1.0,
    "packed"=>false,
    "value"=>1000.0
    }
```

**NOTE**: Skip ahead to **Step 5** if you've already copied and pasted one of the above items into `shiphawk-irb`.
The longer way to create an item is via the `item_object` method. We can use the average dimensions returned with the database item. However, if you already know the dimensions of the package you're shipping, we recommend you use them instead for each of the variables below.

```ruby
item_id = sofa['id']
length  = sofa['avg_length']
width   = sofa['avg_width']
height  = sofa['avg_height']
weight  = sofa['avg_weight']
packed  = false
value   = 10
```

This gives us enough information to create an item object.

```ruby
sofa = ShipHawk::Items.item_object(
  	item_id,
  	length,
  	width,
  	height,
  	weight,
  	packed,
  	value,
)
```
**Note:** Repeat this process for multiple items if you'd like.

#### Step 5: Add Items to your cart

Finally, add your items to the `items_cart`. We're only going to use `big_sofa` from the previous step. If you've created more than one item, you'll need to add each item to the `items_cart` array like so:
```ruby
items_cart.push(big_sofa)
```

#### Step 6: Let's get Rates for the Items we want to ship.

In order to get Rates, we need a `to_zip`, `from_zip`, and our `items_cart`. We already have our origin and destination address objects and we **must** use the `zip` from each.

```ruby
from_zip =  origin_address['zip']
to_zip   =  destination_address['zip']
```
Now we have the minimum requirements to get Rates

```ruby
rates = ShipHawk::Rates.build(
	"to_zip" => to_zip,
	"from_zip" => from_zip,
	"items" => items_cart
)
```

To see how many rates were created, type:
```ruby
rate_count = rates.count
```

Lets select the lowest and the highest rate for the sake of comparison.
```ruby
lowest_rate  = rates.first
highest_rate = rates.last

lowest_total_price  = lowest_rate['total_price']
highest_total_price = highest_rate['total_price']
```

#### Step 7: Time to book a Shipment.

In order to book a shipment, we need, at minimum, a `destination_address`, `origin_address`, `pickup[start_time]` and a `rate_id`. We already have our origin and destination address objects. Let's first get the `id` of the `rate` we selected.

```ruby
rate_id = lowest_rate['id']
pickup_start_time = "2015-12-29 19:00:00"
```

We now have everything we need to book our first shipment. Cool.
```ruby
shipment = ShipHawk::Shipments.book(
	:rate_id => rate_id,
	:pickup=>[{:start_time=>pickup_start_time}], 
	:origin_address => origin_address,
	:destination_address => destination_address
)

# Finally, let's check to see if our shipment was booked. We should be able to find it in the ShipHawk DB.
shipment_id = shipment['details']['id'].to_s
booked_shipment = ShipHawk::Shipments.find(shipment_id)
```
----



Other Cool Things you can do with our Client
--------------------

#### Zip Codes

```ruby
all_zips = ShipHawk::ZipCodes.all
paginated_zips = ShipHawk::ZipCodes.all(:page => 1, :per_page => 20)
zip_query = ShipHawk::ZipCodes.search(:q => '90210')
```

#### Items

```ruby
item_by_id = ShipHawk::Items.find('942')
item_query = ShipHawk::Items.search(:q => 'Aston Martin')
all_items  = ShipHawk::Items.all
paginated  = ShipHawk::Items.all(:page => 1, :per_page => 100)
```
#### Shipments

```ruby
all_my_shipments = ShipHawk::Shipments.all
paginated = ShipHawk::Shipments.all(:page => 1, :per_page => 10)
shipment_by_id = ShipHawk::Shipments.find('1019314')

# retrieve the customer notes for a shipment
notes = ShipHawk::Shipments.get_notes('1019314')

# create a customer note for a shipment
customer_note = ShipHawk::Shipments.build_note(
    '1019314', 
    :tag => 'delivery update', 
    :body => 'shipment will be delayed'
)

# retrieve the current status of a shipment
tracking = ShipHawk::Shipments.get_tracking('1019314')

# NOTE: small parcel shipments do not have address labels or bols
bol_url = ShipHawk::Shipments.get_bol_url('1019314')
address_labels = ShipHawk::Shipments.get_address_labels('1019314')

# update a shipment (after editing shipment params, pass in the entire shipment object)
shipment = ShipHawk::Shipments.find('1019314') # get shipment to update
shipment.details.special_request = 'handle with care'  # edit shipment params
shipment.details.xid = 'Z123123123'
shipment.pickup.address.state = 'NY'
updated_shipment = ShipHawk::Shipments.update('1019165', shipment) # update shipment

#Cancel a shipment
cancel_shipment = ShipHawk::Shipments.cancel('1019164')

# check to see if shipment has been canceled
status = ShipHawk::Shipments.find('1019164').details.status

# bulk updates the status of 1 or more shipments, use one of the following statuses below
# [ :ordered, :confirmed, :scheduled_for_pickup, :agent_prep, :ready_for_carrier_pickup, :in_transit, :delivered, :exception ]

bulk_update_status = ShipHawk::Shipments.update_statuses(:shipment_ids=>[1019165, 1019166],:status=> :ready_for_carrier_pickup)

# Note, you cannot update the status of a shipment that has already been cancelled.
```
#### Shipment WebHooks

```ruby
# Subscribe to status updates for a shipment
subscribe = ShipHawk::Shipments.subscribe('1019314', :callback_url => 'https://customer.com/api/shipment_status?api_key=3873')
```
And 20+ more cool things to do with shipments, see here: **[Shipments End Points](https://github.com/ShipHawk/shiphawk-ruby/blob/superior_branch/lib/shiphawk/api/shipments.rb)**
#### Dispatches

```ruby
# only certain carriers are dispatchable. Contact aaron@shiphawk.com for our dispatch list
# NOTE: Small Parcel carriers do not need to be dispatched assuming that you have a daily pickup.

ShipHawk::Dispatches.build(
	:shipment_id => '1019314',
	:pickup_start_time => "2015-12-11T00:42:09Z",
	:pickup_end_time => "2015-12-13T00:42:09Z",
	:dispatch_instructions => 'pick up package on back porch. Beware dog.' 
)
```
#### Network Locations

**[Network Locations End Points](https://github.com/ShipHawk/shiphawk-ruby/blob/superior_branch/lib/shiphawk/api/network_locations.rb)**

#### Carriers

```ruby
carrier_logos = ShipHawk::Carriers.logos
my_carrier_credentials = ShipHawk::Carriers.credentials
```

#### Products

```ruby
# retrieve a product ( this will only work if you have created products. see next step )
product_sku = 'B002VH3AMK'
product = ShipHawk::Products.find_by(product_sku)

# create a product

# NOTE: In order to create a product, we first need a Category to store it in and our account_id
all_categories = ShipHawk::Categories.find_all
category = all_categories.categories.first.category
account_id = categories.account_id

#if you don't have any categories, you can create one like this:
new_category = ShipHawk::Categories.build(
    :account_id => nil,
    :category => "Fiction",
    :parent_category => "Books",
    :name => "Books - Fiction",
    :path => "books/fiction",
    :url => "http://amzn.com/B002VH3AMK"
)

# Now you can create a Product using the new_category we created and your account_id:
category_name = new_category.category

product = ShipHawk::Products.build(
    :product_sku => 'B002VH3AMK',
    :product_name_title => "Tropic of Cancer",
    :long_description => "Tropic of Cancer (Paperback)",
    :package_type => 'Box',
    :packing_code => '1213123',
    :account_id => account_id,
    :product_url => 'http://amzn.com/B002VH3AMK',
    :rh_category => 'Fiction',
    :standard_price => 19.99,
    :product_condition => 'excellent',
    :product_height => 1.2,
    :product_width => 4.2,
    :product_length => 4.4,
    :product_weight => 2.2
)

# Now let's make sure our product was created. We can find it by product_sku.
product_sku = product.product_sku
new_product = ShipHawk::Products.find_by(product_sku)

```

#### Public (Auth not required)

Track a Shipment

*(contact ahawk@shiphawk.com about integrating this end point with our awesome Tracking Widget built w/ cutting edge technology)*


```ruby
# trak by carrier code and tracking number
tracking_info = ShipHawk::Public.track(
	:code => 'daylight',
	:tracking_number => '1231231231'
)

# track by shipment id
tracking_info = ShipHawk::Public.track(
	:id => '1019314'
)

status = tracking_info.status
status_updates = tracking_info.status_updates
```

If you've forgotten the tracking number, you can access it via the Shipments end point.

```ruby
tracking_number = ShipHawk::Shipments.find('1019314').details.tracking_number
```
---


Documentation
--------------------

Up-to-date documentation at: https://shiphawk.com/api-docs

Tests
--------------------

```
rspec spec
```
