class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  def average
    sum_rating = []
    self.ratings.each do |rating|
      sum_rating << rating
    end
    sum_rating.sum / @restaurant.self.size
  end

end
