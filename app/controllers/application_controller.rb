require './config/environment'
require 'rack-flash'

class  ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
      set :session_secret, "password_security"
      use Rack::Flash
    end

    get "/" do
      erb :index
    end



    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
          User.find(session[:user_id])
      end
    end

  end