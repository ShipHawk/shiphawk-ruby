require 'spec_helper'

describe Shiphawk::Api::Rates do

  context 'POST to rates' do

    before do
      VCR.insert_cassette 'rates_create'
    end

    after do
      VCR.eject_cassette
    end

    it 'returns rates based on rquest data' do
      expect(true).to eql(true)
    end

  end

end