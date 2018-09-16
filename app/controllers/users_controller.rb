class UsersController < ApplicationController

  get "/login" do
    erb :"users/login"
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/countries"
    else
      redirect "/login"
    end
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/countries"
    else
      flash[:message] = user.errors.full_messages.join(',')
      redirect "/signup"
    end
  end


  get "/logout" do
    session.clear
    redirect "/login"
  end

end
