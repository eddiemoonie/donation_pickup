class ReviewsController < ApplicationController

  get '/restaurants/:slug/reviews/:id' do
    redirect_if_not_logged_in
    @restaurant = Restaurant.find_by_slug(params[:slug])
    @review = Review.find(params[:id])
    erb :'reviews/show'
  end

  get '/restaurants/:slug/reviews/:id/edit' do
    redirect_if_not_logged_in
    @restaurant = Restaurant.find_by_slug(params[:slug])
    @review = Review.find(params[:id])
    erb :'reviews/edit'
  end

  patch '/restaurants/:slug/reviews/:id' do
    redirect_if_not_logged_in
    @restaurant = Restaurant.find_by_slug(params[:slug])
    @review = Review.find(params[:id])
    if @restaurant && @review && !current_user.admin?
      @review.update(
        :content => params[:content],
        :rating => params[:rating]
      )
      redirect to "/restaurants/#{@restaurant.slug}/reviews/#{@review.id}"
    end
  end

end
