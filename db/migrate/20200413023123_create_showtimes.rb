class CreateShowtimes < ActiveRecord::Migration[6.0]
  def change
    create_table :showtimes do |t|
      t.references :theatre, foreign_key: true, null: false
      t.references :movie, foreign_key: true, null: false
      t.string :auditorium, limit: 16, null: false
      t.timestamp :start_time
      t.timestamps
    end
  end
end
