class CreateTheatres < ActiveRecord::Migration[6.0]
  def change
    create_table :theatres do |t|
      t.string :name, limit: 256
      t.string :address_line_1, limit: 256
      t.string :address_line_2, limit: 256
      t.string :address_city, limit: 128
      t.string :address_state, limit: 2
      t.string :address_zip_code, limit: 9
      t.string :phone_number, limit: 10
    end
  end
end
