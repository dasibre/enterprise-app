class AddRatingIdFkToMovies < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          ALTER TABLE movies
            ADD COLUMN rating_id INTEGER NOT NULL;
          ALTER TABLE movies
            ADD CONSTRAINT fk_movie_rating_id FOREIGN KEY (rating_id) REFERENCES ratings;
        SQL
      end

      direction.down do
        execute <<-SQL
          ALTER TABLE movies
            DROP COLUMN rating_id
        SQL
      end
    end
  end
end
