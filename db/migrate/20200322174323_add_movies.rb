class AddMovies < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
           create table movies(
              id SERIAL PRIMARY KEY,
              name varchar(256),
              length_minutes integer,
              rating varchar(8)
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
