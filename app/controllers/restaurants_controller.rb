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
        :zipcode => params[:zipcode],
        :user_id => current_user.id
      )
      redirect to '/restaurants'
    end
  end

  get '/restaurants/:slug' do
    redirect_if_not_logged_in
    @restaurant = Restaurant.find_by_slug(params[:slug])
    erb :'/restaurants/show'
  end

  post '/restaurants/:slug' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if params[:rating] != ""
      Review.create(
        :user_id => current_user.id,
        :restaurant_id => @restaurant.id,
        :rating => params[:rating],
        :content => params[:content]
      )
      redirect to "/restaurants/#{@restaurant.slug}"
    end
  end
end
