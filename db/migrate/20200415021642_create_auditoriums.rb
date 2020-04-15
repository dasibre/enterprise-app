class CreateAuditoriums < ActiveRecord::Migration[6.0]
  def change
    create_table :auditoriums do |t|
      t.references :theatre, null: false, foreign_key: true
      t.string :auditorium_identifier, null: false
      t.integer :seats_available, null: false
    end

    add_index(:auditoriums, [:auditorium_identifier, :theatre_id], unique: true)

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE auditoriums
            ADD CONSTRAINT aud_id_length_chk
             CHECK (length(auditorium_identifier) >= 1);
        SQL
      end
      dir.down do
        execute <<-SQL
         DROP TABLE auditoriums;
        SQL
      end
    end
  end
end
