require 'sinatra'
require 'sinatra/activerecord'
require 'will_paginate'
require 'will_paginate/active_record'

require_relative 'listing.rb'

class App < Sinatra::Base
  before do
    content_type :json
  end

  get '/' do
    'Howdy'
  end

  get '/listings' do
    listings = Listing.search(params)
    paginate(listings)
    geo_json(listings)
  end

  def paginate(listings)
    curr = params[:page] ||= 1

    response.headers['Total'] = listings.total_entries.to_s
    response.headers['Per-Page'] = "100"
    response.headers['Page'] = curr.to_s
    response.headers['Link'] = page_links(curr, listings)
  end

  def page_links(curr, listings)
    curr = curr.to_i
    last = listings.total_entries / 100

    arr = [page_link(1, 'first')]
    arr << page_link(curr + 1, 'next') unless curr == last
    arr << page_link(curr - 1, 'prev') unless curr == 1
    arr << page_link(last, 'last')

    arr.join(', ')
  end

  def page_link(page, rel)
   %Q(<#{uri(page)}>; rel="#{rel}")
  end

  def uri(page = nil)
    query = params.merge("page" => page).to_query
    URI::HTTP.build(host: ENV['HOST'],
                    path: '/listings',
                    query: query)
  end

  def geo_json(listings)
    {
      'type' => 'FeatureCollection',
      'features' => listings.map(&:to_geo_json)
    }.to_json
  end

  def lookup(params)

  end
end
