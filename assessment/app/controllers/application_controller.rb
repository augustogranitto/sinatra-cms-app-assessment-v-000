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

    get "/signup" do
      erb :signup
    end

    post "/signup" do
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      if user.save
        session[:user_id] = user.id
        redirect "/home"
      else
        session[:user] = user.id
        redirect "/home"
      else
        flash[:message] = user.errors.full_messages.join(',')
        redirect "/signup"
      end
    end

    get "/login" do
      erb :login
    end

    post "/login" do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/home"
      else
        redirect "/login"
      end
    end

    get "/logout" do
      session.clear
      redirect "/login"
    end

    get "/countries" do
      @countries = Country.all
      erb :countries
    end

    get "/countries/new" do
      erb :'countries/new'
    end

    post "/countries" do
      if !params["country"]["name"].empty?
        @country = Country.create(params[:country])
        if !params["sight"]["name"].empty?
          @country.sights << Sight.find_or_create_by(name: params["sight"]["name"])
        end
        redirect "/sight/#{@sight.id}"
      else
        flash[:message] = "Sight name cannot be empty"
        redirect "/sight/#{@sight.id}/edit"
      end
    end

    delete '/sights/:id' do
      @sight = sight.find(params[:id])
      if current_user = @sight.user
        @sight.destroy
      else
        flash[:message] = "You cannot delete destinations you did not create"
      end
        redirect "/home"
      end
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
