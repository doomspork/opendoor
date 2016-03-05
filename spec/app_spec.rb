require 'spec_helper'

describe App do
  describe 'GET /' do
    it 'will return a simple message' do
      get '/'
      expect(last_response.body).to eq 'Howdy'
    end
  end

  describe 'GET /listings' do
    before do
      Listing.new(id: 1, price: 10000, bathrooms: 2, bedrooms: 2).save
      Listing.new(id: 2, price: 8000, bathrooms: 1, bedrooms: 1).save
    end

    describe 'price filtering' do
      it 'will filter on max_price' do
        get '/listings', max_price: 9000
        expect(geo_json_features.first['properties']['id']).to eq 2
      end

      it 'will filter on min_price' do
        get '/listings', min_price: 9000
        expect(geo_json_features.first['properties']['id']).to eq 1
      end

      it 'will filter on price' do
        get '/listings', max_price: 10000, min_price: 7000
        expect(geo_json_features.size).to eq 2
      end
    end

    describe 'bathroom filtering' do
      it 'will filter on max_bath' do
        get '/listings', max_bath: 1
        expect(geo_json_features.first['properties']['id']).to eq 2
      end

      it 'will filter on min_bath' do
        get '/listings', min_bath: 2
        expect(geo_json_features.first['properties']['id']).to eq 1
      end

      it 'will filter on price' do
        get '/listings', max_bath: 3, min_bath: 1
        expect(geo_json_features.size).to eq 2
      end
    end

    describe 'bedroom filtering' do
      it 'will filter on max_bed' do
        get '/listings', max_bed: 1
        expect(geo_json_features.first['properties']['id']).to eq 2
      end

      it 'will filter on min_bed' do
        get '/listings', min_bed: 2
        expect(geo_json_features.first['properties']['id']).to eq 1
      end

      it 'will filter on beds' do
        get '/listings', max_bed: 3, min_bed: 1
        expect(geo_json_features.size).to eq 2
      end
    end
  end
end
