class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/new'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect "/signup"
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
    end
  end

end
