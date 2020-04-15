require 'test_helper'
require 'pry-rails'

class Physical::Movies::MovieTest < ActiveSupport::TestCase

  describe "Movie application layer constraints" do
    describe "no name" do
      it "does not catch an input error" do
        movie = Physical::Movies::Movie.new(length_minutes: '10')
        _(movie.new_record?).must_equal true, "Model constraints did not catch null name"
      end
    end

    describe "empty name" do
      it "does not catch empty name" do
        movie = Physical::Movies::Movie.new(name: '', length_minutes: '10')
        assert !movie.save, "Model constraints did not catch empty name"
      end
    end
    describe "duplicate movie" do
      it "should fail with duplicate error msg" do
        pg_rating = Physical::Movies::Rating.new(name: "Unrated")
        movie = Physical::Movies::Movie.new(name: 'Matrix', length_minutes: '10', rating: pg_rating)
        movie_dup = movie.clone
        movie.save!
        assert !movie_dup.save, "Model constraints did not catch dup movie"
      end
    end

    describe "rating" do
      context "no rating" do
        it "should fail model validation" do
          movie = Physical::Movies::Movie.new(name: 'Matrix', length_minutes: '10')
          assert !movie.save, "Model constraints did not catch null rating"
        end
      end
    end

    describe "length minutes" do
      context "null length" do
        it "should fail validation" do
          rating = Physical::Movies::Rating.new(name: 'PG')
          movie = Physical::Movies::Movie.new(name: 'Matrix', rating: rating)
          assert !movie.save, "Model constraints did not catch null length"
        end
      end

      context "zero length movie" do
        it "should fail validation" do
          pg_rating = Physical::Movies::Rating.new(name: "PG")
          movie = Physical::Movies::Movie.new(name: 'Matrix', rating: pg_rating, length_minutes: '0')
          assert !movie.save, "Model constraints did not catch 0 length minutes"
        end
      end

      context "negative movie length" do
        it "should fail validation" do
          movie = Physical::Movies::Movie.new(name: 'Matrix', length_minutes: '-1')
          assert !movie.save, "Model constraints did not catch negative length minutes"
        end
      end

      context "non integer movie length" do
        let(:pg_rating) { Physical::Movies::Rating.new(name: "PG") }
        let(:movie) { Physical::Movies::Movie.new(name: 'Matrix', rating: pg_rating, length_minutes: 'Ten') }

        it "should not save" do
          assert !movie.save, "Model constraints did not catch non integer length minutes"
        end

        it "fail validation with length_minutes is not a number" do
          movie.save
          movie.errors.messages[:length_minutes].must_include "is not a number"
        end
      end
    end
  end

  describe "Movie data layer tests" do
    describe "empty movie name" do
      it "should raise a database error" do
        movie = Physical::Movies::Movie.new(name: '', length_minutes: '10')
        custom_test_for_db_error("Database did not catch empty name") do
          movie.save!(validate: false)
        end
      end
    end

    describe "no movie name" do
      it "should raise a database error" do
        movie = Physical::Movies::Movie.new(length_minutes: '10')
        custom_test_for_db_error("Database did not catch null name") do
          movie.save!(validate: false)
        end
      end
    end

    describe "duplicate movie" do
      it "should fail with duplicate error msg" do
        movie = Physical::Movies::Movie.new(name: 'Matrix', length_minutes: '10')
        movie_dup = movie.clone
        custom_test_for_db_error("Database did not catch duplicate movie") do
          movie.save!(validate: false)
          movie_dup.save!(validate: false)
        end
      end
    end

    describe "no rating" do
      it "should fail with db error error msg" do
        movie = Physical::Movies::Movie.new(name: 'Matrix', length_minutes: '10')
        custom_test_for_db_error("Database did not catch null rating") do
          movie.save!(validate: false)
        end
      end
    end

    describe "0 length movie" do
      it "should fail with db error error msg" do
        pg_rating = Physical::Movies::Rating.new(name: "PG")
        movie = Physical::Movies::Movie.new(name: 'Matrix', rating: pg_rating, length_minutes: '0')
        custom_test_for_db_error("Database did not catch 0 length") do
          movie.save!(validate: false)
        end
      end
    end

    describe "negative length movie" do
      it "should fail with db error error msg" do
        movie = Physical::Movies::Movie.new(name: 'Matrix', length_minutes: '-10')
        custom_test_for_db_error("Database did not catch 0 length") do
          movie.save!(validate: false)
        end
      end
    end
  end
end


# These negative tests attempt to do something
# that should not work.
# You should not be able to save movie with negative length