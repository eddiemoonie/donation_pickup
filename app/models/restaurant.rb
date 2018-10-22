class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :restaurant_users
  has_many :users, :through => :restaurant_users

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{|instance| instance.slug == slug}
  end

  def average_rating
    if self.reviews.exists?
      (self.reviews.inject(0){|sum, review| sum + review[:rating]})/(self.reviews.size).round(1)
    end
  end

end
