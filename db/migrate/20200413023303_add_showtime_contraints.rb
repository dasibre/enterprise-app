class AddShowtimeContraints < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE showtimes
            ADD CONSTRAINT aud_check
              CHECK (length(auditorium) > 5);
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE showtimes
            DROP CONSTRAINT aud_check
        SQL
      end
    end
  end
end
