module ShipHawk
  # Shipments API
  #
  # @see https://shiphawk.com/api-docs
  #
  # The following API actions provide the CRUD interface to managing Shipments.
  #

  class Shipments < Resource

    def self.book(params={})
      api_key = ShipHawk.configure.api_key
      api_base = ShipHawk.configure.base_url
      begin
        response = RestClient.post("#{api_base}/shipments?api_key=#{api_key}", params.to_json, :content_type => :json)
        puts "Response status: #{response.code}"
        JSON.parse(response) if response
      rescue => e
        JSON.parse(e.response) if e
      end
    end

    def self.cancel(shipment_id, params={})
      response, api_key = ShipHawk::ApiClient.request(:delete, "/shipments/#{shipment_id}", @api_key, params)
      puts response
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # update/edit a particular Shipment
    def self.update(shipment_id, params={})
      api_key = ShipHawk.configure.api_key
      api_base = ShipHawk.configure.base_url
      begin
        response = RestClient.put("#{api_base}/shipments/#{shipment_id}?api_key=#{api_key}", params.to_json, :content_type => :json, :accept => :json)
        puts "Response status: #{response.code}"
        JSON.parse(response) if response
      rescue => e
        JSON.parse(e.response) if e
      end
    end

    # update ITN (Internal Transaction Number) for an international shipment
    # @params [ itn_number ], string, required
    def self.update_itn(shipment_id, params={})
      response, api_key = ShipHawk::ApiClient.request(:put, "/shipments/#{shipment_id}", @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # bulk update the status of one or more shipments
    # requires :shipment_ids,    type: Array[Integer]
    # requires :status, type: Symbol, values: Shipment::ALL_STATUSES

    # ALL_STATUSES = [
    #    :ordered,
    #    :confirmed,
    #    :scheduled_for_pickup,
    #    :agent_prep,
    #    :ready_for_carrier_pickup,
    #    :in_transit,
    #    :delivered,
    #    :exception,
    #    :cancelled,
    # ]

    def self.update_statuses(params={})
      api_key = ShipHawk.configure.api_key
      api_base = ShipHawk.configure.base_url
      response = RestClient.put("#{api_base}/shipments/status?api_key=#{api_key}", params.to_json, :content_type => :json, :accept => :json)
      begin
        puts "Response status: #{response.code}"
        params[:shipment_ids].each { |k,v|
          shipment = self.find(k) # get updated shipment after update
          puts "Status for Shipment #{k} updated to #{shipment.details.status}" if shipment
        }
      rescue => e
        JSON.parse(e.response) if e
      end
    end

    # Subscribe to status updates for a shipment
    # requires :id, type: Integer
    # requires :callback_url, type: String
    # optional :events, type: Array, default: []

    def self.subscribe(shipment_id, params)
      api_key = ShipHawk.configure.api_key
      api_base = ShipHawk.configure.base_url
      response = RestClient.put("#{api_base}/shipments/#{shipment_id}/tracking?api_key=#{api_key}", params.to_json, :content_type => :json, :accept => :json)
      begin
        puts "Response status: #{response.code}"
        JSON.parse(response) if response
      rescue => e
        JSON.parse(e.response) if e
      end
    end

    # get a shipment's BOL pdf url
    def self.get_bol_url(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/bol", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # Return a shipment's BOL pdf binary
    def self.get_bol_pdf(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/bol.pdf", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    #get tracking info for a specific shipment
    def self.get_tracking(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/tracking", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    #return a shipment's address labels url
    def self.get_address_labels(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/address_labels", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # return all dispatches associated with a shipment
    def self.get_dispatches(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/dispatches", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # dispatch a shipment

    # requires :id, type: Integer, documentation: {type: 'integer'}
    # requires :pickup_start_time, type: DateTime, documentation: {type: 'datetime'}
    # requires :pickup_end_time, type: DateTime, documentation: {type: 'datetime'}
    # optional :dispatch_instructions, type: String, documentation: {type: 'string'}

    def self.dispatch(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:post, "/shipments/#{shipment_id}/dispatches", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # retrieve the documents on a shipment
    def self.get_documents(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/documents", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # update document type on the shipment
    # @params [ document_id ], integer, required
    #         [ document_type ], string, required

    def self.update_documents(shipment_id, params={})
      response, api_key = ShipHawk::ApiClient.request(:put, "/shipments/#{shipment_id}/documents", @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # retrieve the customer notes for a shipment
    def self.get_notes(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/notes", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # create a customer note for a shipment
    def self.create_notes(shipment_id, params={})
      response, api_key = ShipHawk::ApiClient.request(:post, "/shipments/#{shipment_id}/notes", @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # retrieve a shipment's packages label URLs
    def self.get_label_urls(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/packages/labels", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # retrieve a shipment's packages labels combined PDF URL
    def self.get_labels_pdf(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/packages/labels/combined", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # regenerates BOL and Address Label with load manifest information
    def regenerate_shipment_documentation

    end

    # return a shipment's Commercial Invoice pdf url
    def self.get_commercial_invoice_url(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/commercial_invoice", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # return a shipment's Commercial Invoice pdf binary
    def self.get_commercial_invoice_pdf(shipment_id)
      response, api_key = ShipHawk::ApiClient.request(:get, "/shipments/#{shipment_id}/commercial_invoice.pdf", @api_key)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # update tracking number for a shipment
    # @params [ tracking_number ], string, required
    def self.update_tracking_number(shipment_id, params={})
      response, api_key = ShipHawk::ApiClient.request(:put, "/shipments/#{shipment_id}/tracking_number", @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    # reconcile a shipments shipping cost
    # @params [ id ], integer, required
    #         [ carrier ], string, required
    #         [ sum_of_costs ], number, required

    def self.reconcile(shipment_id, params={})
      response, api_key = ShipHawk::ApiClient.request(:post, "/shipments/#{shipment_id}/reconcile/shipping_cost", @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    end

end
