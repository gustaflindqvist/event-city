require 'rubygems'
require 'sinatra'
require 'rgeo/geo_json'

class EventCity < Sinatra::Base
  set :static, true
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "static") }

  get '/' do
    erb :index
  end

  get '/events' do
    # Stub events connected to position
  end
end
