require './config/environment'
require 'rack-flash'

class  ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
      set :session_secret, "password_security"
      use Rack::Flash

    get "/" do
      erb :index
    end

  end
