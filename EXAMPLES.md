# Shiphawk::Client Gem Examples

## API Key Authentication

Here's an example of authenticating with the Shiphawk::Client API

```ruby
require 'rubygems'
require 'shiphawk-ruby'

# get an item based on item id
client = Shiphawk::Client.new('api_token')
client.items_show 2335
```

## Users

Here are some examples of accessing and managing user information:

