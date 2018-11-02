require 'rack-flash'
class RestaurantsController < ApplicationController
  use Rack::Flash

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
    if params[:name] == "" || params[:street] == "" || params[:city] == "" || params[:state] == "" || params[:zipcode] == ""
      flash[:message] = "Please fill in all entries!"
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
    @review = @restaurant.reviews.find{|instance| instance.user.id == current_user.id}
    erb :'/restaurants/show'
  end

  post '/restaurants/:slug' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if params[:rating] = ""
      flash[:message] = "Please rate the business!"
      redirect to "/restaurants/#{@restaurant.slug}"
    else
      Review.create(
        :user_id => current_user.id,
        :restaurant_id => @restaurant.id,
        :rating => params[:rating],
        :content => params[:content]
      )
      redirect to "/restaurants/#{@restaurant.slug}"
    end
  end

  get '/restaurants/:slug/edit' do
    redirect_if_not_logged_in
    if current_user.admin?
      @restaurant = Restaurant.find_by_slug(params[:slug])
      erb :'/restaurants/edit'
    end
  end

  patch '/restaurants/:slug' do
    redirect_if_not_logged_in
    @restaurant = Restaurant.find_by_slug(params[:slug])
    if @restaurant && current_user.admin?
      if params[:name] == "" || params[:street] == "" || params[:city] == "" || params[:state] == "" || params[:zipcode] == ""
        flash[:message] = "Please fill in all the entries"
        redirect to "/restaurants/#{@restaurant.slug}/edit"
      else
        @restaurant.update(
          :name => params[:name],
          :street => params[:street],
          :city => params[:city],
          :state => params[:state],
          :zipcode => params[:zipcode]
        )
        redirect to "/restaurants/#{@restaurant.slug}"
      end
    end
  end

  delete '/restaurants/:slug/delete' do
    redirect_if_not_logged_in
    if current_user.admin?
      @restaurant = Restaurant.find_by_slug(params[:slug])
      if @restaurant
        @restaurant.delete
      end
    end
    redirect to "/users/#{current_user.slug}"
  end
end
