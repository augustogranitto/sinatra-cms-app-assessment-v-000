class CountriesController < ApplicationController


      get "/countries" do
        @countries = Country.all
        erb :"countries/index"
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

      get '/countries/:id/edit' do 
        @country = Country.find(params[:id])
        erb :'/destinations/edit'
      end 
        
      
      delete '/sights/:id' do
        @sight = sight.find(params[:id])
        if current_user = @sight.user
          @sight.destroy
        else
          flash[:message] = "You cannot delete countries you did not create"
        end
          redirect "/home"
        end
      end
