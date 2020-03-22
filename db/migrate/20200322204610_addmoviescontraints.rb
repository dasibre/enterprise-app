class Addmoviescontraints < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
           ALTER TABLE movies
             ALTER COLUMN name SET NOT NULL;
           ALTER TABLE movies
             ALTER COLUMN rating SET NOT NULL;
           ALTER TABLE movies
             ALTER COLUMN length_minutes SET NOT NULL;
           ALTER TABLE movies
             ADD CONSTRAINT namechk check ( length(name) > 0 )
             NOT VALID;
           ALTER TABLE movies
             ADD CONSTRAINT lengthchk check ( length_minutes > 0 );
           ALTER TABLE movies
             ADD CONSTRAINT ratingschk check(rating in ('Unrated', 'G', 'PG', 'PG-13', 'R', 'NC-17'));
        SQL
      end

      direction.down do
        execute <<-SQL
          ALTER TABLE movies
             ALTER COLUMN name DROP NOT NULL;``
          ALTER TABLE movies
             ALTER COLUMN rating DROP NOT NULL;
          ALTER TABLE movies
             ALTER COLUMN length_minutes DROP NOT NULL;
          ALTER TABLE movies
            DROP CONSTRAINT lengthchk;
          ALTER TABLE movies
            DROP CONSTRAINT ratingschk;
          ALTER TABLE movies
            DROP CONSTRAINT namechk;
        SQL
      end
    end
  end
end

# When data in a column will become invalid
# Include a NOT VALID in the alter table statement
# ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK (column IS NOT NULL) NOT VALID;