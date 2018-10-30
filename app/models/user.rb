class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews
  has_many :restaurant_user
  has_many :restaurants, :through => :restaurant_user

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{|instance| instance.slug == slug}
  end

  def restaurants_owned?
    self.restaurants.exists?
  end

end
