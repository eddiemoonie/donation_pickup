require 'rack-flash'
class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    @restaurants = Restaurant.all
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect to "/users/#{current_user.slug}"
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to "/users/#{current_user.slug}"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password], :admin => params[:admin])
      session[:user_id] = @user.id
      redirect to "/users/#{current_user.slug}"
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to "/users/#{current_user.slug}"
    end
  end

  post '/login' do
    user = User.find_by(:username  => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/users/#{current_user.slug}"
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
