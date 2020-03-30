module Physical
  module Movies
    class Showtime < ApplicationRecord
      belongs_to :theatre
      belongs_to :movie
    end
  end
end