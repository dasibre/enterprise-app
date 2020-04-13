module Physical
  module Movies
    class Showtime < ApplicationRecord
      belongs_to :theatre
      belongs_to :movie

      validates :movie, :theatre, presence: true
    end
  end
end