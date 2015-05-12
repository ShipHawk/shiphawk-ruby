module Shiphawk
  module Api

    attr_accessor :params

    # load dependent code
    autoload :QueryHelpers, 'shiphawk/api/query_helpers'
    autoload :ApiKeys,      'shiphawk/api/api_keys'
    autoload :Company,      'shiphawk/api/company'
    autoload :Items,        'shiphawk/api/items'
    autoload :Rates,        'shiphawk/api/rates'
    autoload :Shipments,    'shiphawk/api/shipments'
    autoload :ZipCodes,     'shiphawk/api/zip_codes'

  end
end
