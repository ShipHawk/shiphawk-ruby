# ShipHawk Ruby Client Library

**ShipHawk** is a powerful shipping API for managing all of your shipping data. We streamline the shipping process for you, making it easy to ship and manage everything from small parcel to freight to multi-palletized shipments. Through use of our client, you will gain insights into the business of shipping that will save your company and clients both time and money.

Our ruby gem provides an easy-to-use wrapper for ShipHawk's V3 REST APIs (note the new and improved V4 endpoints will be released shortly).

Your can easily integrate many different shipping services into your business with this client (see example below). Please sign up for an account here at **https://shiphawk.com** to get your `api_key`.

**Note**: If you're not a developer, be sure to ask us about our **Dashboard**, a slick UI for organizing all your shipping data. We also offer a variety shipping tools and widgets which can greatly simplify your company's shipping needs.

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
ShipHawk::Client::api_key =  'YOUR_API_KEY'
```

---



Example Usage
------------------

In the following example, we're going to make it easy for you to test out our Ruby client and API endpoints. We'll be booking a shipment via the command line. Yes, it is entirely possible to get rates, book and track your shipments etc... from console. All you have to do is `cd` to the directory where you installed ```shiphawk-ruby```.

Once inside the `shiphawk-ruby` directory, type:

```ruby
shiphawk-irb
```
That's it. Now you have complete access to the ShipHawk API. Well...almost. First you need to authorize the Ruby client.

#### Step 1:  Authorize your Client.
copy and paste the line below into your console. Be sure to use the `api_key` you were provided with.
```
ShipHawk::Client::api_key = 'YOUR_API_KEY'
```
Don't have an Api Key? *( contact alex.hawkins@shiphawk.com for more information about obtaining one )*


#### Step 2:  Set the Origin and Destination Address

**Note**: Address and Parcel creation via our Ruby Client will be available with the release of **V4**. For now, let's just create an Address using our search endpoint.

```ruby
origin_address      = ShipHawk::Api::Addresses.search(q: '90120').first
destination_address = ShipHawk::Api::Addresses.search(q: '94539').first
```
#### Step 3:  Create the Items we're Shipping

First create a container for storing all your items. We'll call this our `items_cart` and set it equal to an empty array like so:

```ruby
items_cart = [];
```

Let's assume the item we're shipping is **unpacked**. Now we'll query ShipHawk's product database to find our unpacked item.

```ruby
all_sofas = ShipHawk::Api::Items.search(:q => 'sofa')
all_rings = ShipHawk::Api::Items.search(:q => 'ring')
```

For the sake of simplicity, we're only going to deal with 1 item here. And we're going to select the first item that is returned and save it to a variable called `sofa`.

```ruby
sofa = all_sofas.first
```

Next we'll use the average dimensions returned with the database item. However, if you already know the dimensions of the package you're shipping, we recommend you use them instead for each of the variables below.

```ruby
item_id = sofa['id']
length  = sofa['avg_length']
width   = sofa['avg_width']
height  = sofa['avg_height']
weight  = sofa['avg_weight']
packed  = false
value   = 10
```

This gives us enough information to create our first item object.

```ruby
sofa = ShipHawk::Api::Items.item_object(
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

Finally, add your items to the `items_cart`.
```ruby
items_cart.push(sofa)
items_cart.push(ring)
```

#### Step 4: Let's get Rates for the Items we want to ship.

In order to get Rates, we need a `to_zip`, `from_zip`, and our `items_cart`. We already have our origin and destination address objects and we **must** use the `zip` from each.

```ruby
from_zip =  origin_address.address.zip
to_zip   =  destination_address.address.zip
```

Now we have the minimum requirements to get Rates

```ruby
rates = ShipHawk::Api::Rates.create_rates(
	"to_zip" => to_zip,
	"from_zip" => from_zip,
	"items" => items_cart
)
```

Lets select the first rate that is returned.

```ruby
selected_rate = rates.first
```

#### Step 5: Time to create a Shipment.

In order to create a shipment, we need an `order_email`, `destination_address`, `origin_address`, and a `rate_id`. We already have our origin and destination address objects. Let's first get the `id` of the `rate` we selected.

```ruby
rate_id = selected_rate['id']
```
Next, let's set the order email

```ruby
order_email = biff.tannin@shiphawk.com
```

Finally, we have everything we need to create a shipment. Cool.

```ruby
shipment = ShipHawk::Api::Shipments.create(
	:rate_id => rate_id,
	:origin_address => origin_address,
	:destination_address => destination_address,
	:order_email => order_email
)
```
----



Other Cool Things you can do with our Client
--------------------

#### Zip Codes

```ruby
all_zips = ShipHawk::Api::ZipCodes.all
paginated_zips = ShipHawk::Api::ZipCodes.all(:page => 1, :per_page => 20)
zip_query = ShipHawk::Api::ZipCodes.search(:q => '90210')
```

#### Items

```ruby
item_by_id = ShipHawk::Api::Items.retrieve('942')
item_query = ShipHawk::Api::Items.search(:q => 'Aston Martin')
all_items  = ShipHawk::Api::Items.all
paginated  = ShipHawk::Api::Items.all(:page => 1, :per_page => 100)
```
#### Shipments

```ruby
all_my_shipments = ShipHawk::Api::Shipments.all
paginated = ShipHawk::Api::Shipments.all(:page => 1, :per_page => 10)
shipment_by_id = ShipHawk::Api::Shipments.retrieve('1069967')
bol_url = ShipHawk::Api::Shipments.get_bol_url('1069967')
tracking = ShipHawk::Api::Shipments.get_tracking('1069967')
notes = ShipHawk::Api::Shipments.get_notes('1069967')
address_labels = ShipHawk::Api::Shipments.get_address_labels('1069967')
```

And 20+ more cool things to do with shipments, see here: **[Shipments End Points](https://github.com/ShipHawk/shiphawk-ruby/blob/superior_branch/lib/shiphawk/api/shipments.rb)**
#### Dispatches

```ruby
ShipHawk::Api::Dispatches.create_dispatch(
	:shipment_id => 1082268,
	:pickup_start_time => "2015-12-11T00:42:09Z",
	:pickup_end_time => "2015-12-13T00:42:09Z",
	:dispatch_instructions => 'pick up package on back porch. Beware dog.' )
```

#### Network Locations

**[Network Locations End Points](https://github.com/ShipHawk/shiphawk-ruby/blob/superior_branch/lib/shiphawk/api/network_locations.rb)**


#### Public (Auth not required)

Track a Shipment

*(contact ahawk@shiphawk.com about integrating this end point with our awesome Tracking Widget built w/ cutting edge technology)*


```ruby
tracking_info = ShipHawk::API::Public.shipment_tracking_info(
	:code => 'mxd',
	:tracking_number => '3434343434'
)

status = tracking_info.status
status_updates = tracking_info.status_updates
```

If you've forgotten the tracking number, you can access it via the Shipments end point.

```ruby
ShipHawk::Api::Shipments.retrieve('1069967').details.tracking_number
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
