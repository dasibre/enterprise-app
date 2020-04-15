module Physical
  module Movies
    class Movie < ApplicationRecord
      validates :name, presence: true, uniqueness: true, length: { maximum: 256 }
      validates :length_minutes, presence: true, numericality: { only_integer: true}
      validates :rating, presence: true
      validate  :movie_length

      has_many :showtimes
      belongs_to :rating

      def movie_length
        if length_minutes && length_minutes <= 0
          errors.add(:length_minutes, "must be greater than zero")
        end
      end
    end
  end
end