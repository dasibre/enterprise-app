module Physical
  module Movies
    class Theatre < ApplicationRecord
      has_many :showtimes
    end
  end
end