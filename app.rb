require 'rubygems'
require 'sinatra'
require 'geocoder'

module Margin
  class EventCity < Sinatra::Base
    set :static, true
    set :root, File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, "static") }

    configure do
        yaml = YAML.load_file(settings.config + "/config.yaml")[settings.environment.to_s]
        yaml.each_pair do |key, value|
          set(key.to_sym, value)
        end
    end

    get '/' do
      erb :index
    end

    get '/location/:long/:lat' do
      long = params[:long]
      lat = params[:lat]

      puts "Longitude #{long}"
      puts "Latitude #{lat}"

      # Geocoder.configure(
      #   # geocoding service (see below for supported options):
      #   :lookup => :nominatim,

      #   # geocoding service request timeout, in seconds (default 3):
      #   :timeout => 1,

      #   # set default units to kilometers:
      #   :units => :km,
      # )

      # results = Geocoder.search("Sundsvall", :params => {:countrycodes => "se"})

      # results.each do |item|
      #   p item.place_id
      # end


      file = open("test/test-data.json")
      json = file.read

      parsed = JSON.parse(json)

      content_type :json

      @events = []

      parsed["venues"].each do |s|
        lat = s["geo"]["latitude"]
        lng = s["geo"]["longitude"]

        @events << { :location => {:lat => lat, :lng => lng }}
      end
      @events = @events.to_json
    end
  end
end
