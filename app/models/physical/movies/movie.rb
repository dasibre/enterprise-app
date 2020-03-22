module Physical
  module Movies
    class Movie < ApplicationRecord
      has_many :showtimes
    end
  end
end