class ReviewsController < ApplicationController

  get '/restaurants/:slug/reviews/:id' do
    redirect_if_not_logged_in
    @restaurant = Restaurant.find_by_slug(params[:slug])
    @review = Review.find(params[:id])
    erb :'reviews/show'
  end

end
