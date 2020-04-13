class AddIndices < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          create index theatres_zip_idx on theatres(address_zip_code);
          create index showtimes_start_time_idx on showtimes(start_time);
        SQL
      end

      direction.down do
        execute <<-SQL
          drop index theatres_zip_idx
          drop index showtimes_start_time_idx
        SQL
      end
    end
  end
end
