class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :restaurant_users
  has_many :users, :through => :restaurant_users
end
