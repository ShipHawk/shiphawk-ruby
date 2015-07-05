# Shiphawk::Client

Ruby wrapper for the ShipHawk V3 API. The ShipHawk::Client gem provides an easy-to-use wrapper for ShipHawk's REST APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shiphawk-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shiphawk-ruby

## Usage

[View the Examples](EXAMPLES.md)

## End points

## Errors and Exceptions

When an *error status* is received from the server, the gem will raise an error on the client side:

* 400 raises Shiphawk::Errors::GeneralError
* 401 raises Shiphawk::Errors::UnauthorizedError
* 403 raises Shiphawk::Errors::AccessDeniedError
* 404 raises Shiphawk::Errors::NotFoundError
* 422 raises Shiphawk::Errors::UnprocessableEntityError
* 500 raises Shiphawk::Errors::InformShiphawkError
* 502 raises Shiphawk::Errors::UnavailableError
* 503 raises Shiphawk::Errors::UnavailableError

## Copyright

Copyright (c) 2015 HAWK Applications Inc., [Robert Schmitt](bob@shiphawk.com). See LICENSE for details.
