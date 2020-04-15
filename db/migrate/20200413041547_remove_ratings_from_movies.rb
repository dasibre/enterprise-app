class RemoveRatingsFromMovies < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          ALTER TABLE movies
            DROP COLUMN rating;
        SQL
      end

      direction.down do
        execute <<-SQL
          ALTER TABLE movies
           ADD COLUMN rating varchar(8) NOT NULL check(rating in ('Unrated', 'G', 'PG', 'PG-13', 'R', 'NC-17'));
        SQL
      end
    end
  end
end
