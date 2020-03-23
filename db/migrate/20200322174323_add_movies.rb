class AddMovies < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
           create table movies(
              id SERIAL PRIMARY KEY,
              name varchar(256) NOT NULL UNIQUE check ( length(name) > 0),
              length_minutes integer NOT NULL check(length_minutes > 0 ),
              rating varchar(8) NOT NULL check(rating in ('Unrated', 'G', 'PG', 'PG-13', 'R', 'NC-17'))
            )
          SQL
      end

      direction.down do
        execute <<-SQL
          drop table movies
        SQL
      end
    end
  end
end
