class RestaurantsController < ApplicationController

  get '/restaurants' do
    redirect_if_not_logged_in
    @restaurants = Restaurant.all
    erb :'restaurants/index'
  end

  get '/restaurants/new' do
    redirect_if_not_logged_in
    erb :'restaurants/new'
  end

  post '/restaurants' do
    if params[:name] == ""
      redirect to '/restaurants/new'
    else
      @restaurant = Restaurant.create(
        :name => params[:name],
        :street => params[:street],
        :city => params[:city],
        :state => params[:state],
        :zipcode => params[:zipcode]
      )
      @restaurant.user_id = current_user.id
      redirect to '/restaurants'
    end
  end

end
