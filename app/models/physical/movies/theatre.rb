module Physical
  module Movies
    class Theatre < ApplicationRecord
      has_many :showtimes
      has_many :orders, :class_name => 'Physical::Orders::Order'
    end
  end
end