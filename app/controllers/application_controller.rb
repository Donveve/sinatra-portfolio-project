require './config/environment'
use Rack::Flash
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"

  end

  get "/" do
      erb :index
  end

end
