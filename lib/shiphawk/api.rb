module Shiphawk
  module Api

    attr_accessor :params

    # load dependent code
    autoload :QueryHelpers,     'shiphawk/api/query_helpers'
    autoload :Items,            'shiphawk/api/items'                # get /, get /search, get /:id
    autoload :Rates,            'shiphawk/api/rates'                # get :id, post /
    autoload :ShipmentNotes,    'shiphawk/api/shipment_notes'       # get /:id/notes, post /:id/notes
    autoload :ShipmentTracking, 'shiphawk/api/shipment_tracking'    # get /:id/tracking, put /:id/tracking
    autoload :Shipments,        'shiphawk/api/shipments'            # get /, get :id, get :id/bol, get :id/bol.pdf, post /, put :id, delete :id
    autoload :ShipmentsStatus,  'shiphawk/api/shipments_status'     # put /
    autoload :ZipCodes,         'shiphawk/api/zip_codes'            # get /, get /search

  end
end
