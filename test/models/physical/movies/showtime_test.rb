require "test_helper"
require "pry-rails"

# module DBTestHelper
#   def test_for_db_error(error_msg, &block)
#     begin
#       block.call
#     rescue ActiveRecord::StatementInvalid
#       database_threw_error = true
#     rescue
#       something_else_threw_error = true
#     end
#     assert !something_else_threw_error, "There is an error in our test code"
#     assert database_threw_error && !something_else_threw_error, error_msg
#   end
# end

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

    describe "Database layer referential tests" do
      it "does not allow save with no movie" do
        test_for_db_error "Database allowed save with no movie" do
          st = Physical::Movies::Showtime.new(
              theatre: @theatre,
              auditorium: '1',
              start_time: Time.now.xmlschema
          )
          st.save(validate: false)
        end
      end

      it "does not allow save with no theatre" do
        test_for_db_error "Database allowed save with no theatre" do
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

  protected

  def test_for_db_error(error_msg, &block)
    begin
      yield
    rescue ActiveRecord::StatementInvalid
      database_threw_error = true
    rescue
      something_else_threw_error = true
    end
    assert !something_else_threw_error, "There is an error in our test code"
    assert database_threw_error && !something_else_threw_error, error_msg
  end
end