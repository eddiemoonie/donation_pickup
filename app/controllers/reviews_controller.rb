class ReviewsController < ApplicationController

  get '/restaurants/:slug/edit' do
    @restaurant = Restaurant.find_by_slug(params[:slug])
  end

end
