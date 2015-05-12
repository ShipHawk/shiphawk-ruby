require 'shiphawk'
require 'webmock'
require 'vcr'
require 'faraday'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end
