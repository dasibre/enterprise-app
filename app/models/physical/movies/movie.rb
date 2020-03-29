module Physical
  module Movies
    class Movie < ApplicationRecord
      validates :name, presence: true, uniqueness: true, length: { maximum: 256 }
      validates :length_minutes, presence: true, numericality: { only_integer: true}
      validates :rating, presence: true, inclusion: { in: %w(Unrated G PG PG-13 R NC-17) }
      validate  :movie_length
      has_many :showtimes

      def movie_length
        if length_minutes && length_minutes <= 0
          errors.add(:length_minutes, "must be greater than zero")
        end
      end
    end
  end
end