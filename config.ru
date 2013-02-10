#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'

Bundler.require(:default)

require './app'

use Rack::ShowExceptions

map '/' do
  run Margin::EventCity
end

$stdout.sync = true
