require 'sinatra'
require 'sinatra/activerecord'

require_relative 'listing.rb'

class App < Sinatra::Base
  before do
    content_type :json
  end

  get '/' do
    'Howdy'
  end

  get '/listings' do
    listings = lookup(params)

    geo_json(listings)
  end

  def geo_json(listings)
    {
      'type' => 'FeatureCollection',
      'features' => listings.map(&:to_geo_json)
    }.to_json
  end

  def lookup(params)
    query = Listing.order(:id)

    query = query.where('price >= ?', params[:min_price]) if params[:min_price]
    query = query.where('price <= ?', params[:max_price]) if params[:max_price]

    query = query.where('bedrooms <= ?', params[:max_bed]) if params[:max_bed]
    query = query.where('bedrooms >= ?', params[:min_bed]) if params[:min_bed]

    query = query.where('bathrooms <= ?', params[:max_bath]) if params[:max_bath]
    query = query.where('bathrooms >= ?', params[:min_bath]) if params[:min_bath]

    query.all
  end
end
