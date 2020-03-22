module Physical
  module Movies
    class Showtime < ApplicationRecord
      self.table_name = "movie_showtimes"
      belongs_to :theatre
      belongs_to :movie
    end
  end
end