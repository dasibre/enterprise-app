require 'test_helper'
require 'pry-rails'

class Physical::Movies::MovieTest < ActiveSupport::TestCase

  describe "Movie" do
    describe "empty movie name" do
      it "should raise a database error" do
        movie = Physical::Movies::Movie.new(name: '', rating: 'PG', length_minutes: '10')
        test_for_db_error("Database did not catch empty name") do
          movie.save!
        end
      end
    end

    describe "no movie name" do
      it "should raise a database error" do
        movie = Physical::Movies::Movie.new(rating: 'PG', length_minutes: '10')
        test_for_db_error("Database did not catch null name") do
          movie.save!
        end
      end
    end

    describe "duplicate movie" do
      it "should fail with duplicate error msg" do
        movie = Physical::Movies::Movie.new(name: 'Matrix', rating: 'PG', length_minutes: '10')
        movie_dup = movie.clone
        test_for_db_error("Database did not catch duplicate movie") do
          movie.save!
          movie_dup.save!
        end
      end
    end

    describe "no rating" do
      it "should fail with db error error msg" do
        movie = Physical::Movies::Movie.new(name: 'Matrix', length_minutes: '10')
        test_for_db_error("Database did not catch null rating") do
          movie.save!
        end
      end
    end

    describe "0 length movie" do
      it "should fail with db error error msg" do
        movie = Physical::Movies::Movie.new(name: 'Matrix', rating: 'PG', length_minutes: '0')
        test_for_db_error("Database did not catch 0 length") do
          movie.save!
        end
      end
    end

    describe "negative length movie" do
      it "should fail with db error error msg" do
        movie = Physical::Movies::Movie.new(name: 'Matrix', rating: 'PG', length_minutes: '-10')
        test_for_db_error("Database did not catch 0 length") do
          movie.save!
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


# These negative tests attempt to do something
# that should not work.
# You should not be able to save movie with negative length