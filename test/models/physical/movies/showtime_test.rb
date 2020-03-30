require "test_helper"

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
          rating: "PG",
          length_minutes: "10",
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
  end
end