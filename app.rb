require 'sinatra'
require 'sinatra/activerecord'

class App < Sinatra::Base
  before do
    content_type :json
  end

  get '/' do
    'Howdy'
  end

  get '/listings' do
  end
end
