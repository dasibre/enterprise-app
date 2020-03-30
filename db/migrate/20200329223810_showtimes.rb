class Showtimes < ActiveRecord::Migration[6.0]
  def change
    create_table :showtimes do |t|
      t.references :theatre
      t.references :movie
      t.string :auditorium
      t.timestamp :start_time
      t.timestamps
    end
  end
end
