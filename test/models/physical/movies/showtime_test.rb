require "test_helper"
require "pry-rails"

class Physical::Movies::ShowtimeTest < ActiveSupport::TestCase
  describe "Showtime" do
    before do
      @theatre = Physical::Movies::Theatre.create!(
          name: "Ruby Palace",
          address_line_1: "123 broadway",
          address_city: "Queens Village",
          address_state: "MA",
          address_zip_code: "02139",
          phone_number: "555555555"
          )
      @movie = Physical::Movies::Movie.create!(
          name: "Matrix",
          length_minutes: "10",
          rating: Physical::Movies::Rating.new(name: "PG")
      )
    end

    describe "Model referential integrity tests" do
      describe "add showtime with no movie" do
        it "should not save" do
          st = Physical::Movies::Showtime.new(theatre: @theatre,
                                              auditorium: '1',
                                              start_time: Time.now.xmlschema)
          assert !st.save, "Model validation allowed save with no movie"
        end
      end

      describe "add showtime with no theatre" do
        it "should not save" do
          st = Physical::Movies::Showtime.new(movie: @movie,
                                              auditorium: '1',
                                              start_time: Time.now.xmlschema)
          assert !st.save, "Model validation allowed save with no theatre"
        end
      end
    end

    describe "Database layer referential tests" do
      it "does not allow save with no movie" do
        custom_test_for_db_error "Database allowed save with no movie" do
          st = Physical::Movies::Showtime.new(
              theatre: @theatre,
              auditorium: '1',
              start_time: Time.now.xmlschema
          )
          st.save(validate: false)
        end
      end

      it "does not allow save with no theatre" do
        custom_test_for_db_error "Database allowed save with no theatre" do
          st = Physical::Movies::Showtime.new(
              movie: @movie,
              auditorium: '1',
              start_time: Time.now.xmlschema
          )
          st.save(validate: false)
        end
      end
    end
  end
end