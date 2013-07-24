require 'test_helper'
require File.expand_path("../../app/validators/date_format_validator",  __FILE__)

class TestModel
  include ActiveModel::Validations
  attr_accessor :date

  validates :date, date_format: true
end

class DateFormatValidatorTest < ActiveSupport::TestCase
  def assert_valid_date(date)
    t = TestModel.new
    t.date = date
    assert t.valid?, "Date `#{date}` should be valid"
  end

  def assert_invalid_date(date)
    t = TestModel.new
    t.date = date
    assert !t.valid?, "Date `#{date}` should be invalid"
  end

  test "invalid date" do
    assert_invalid_date "a"
    assert_invalid_date "today"
    assert_invalid_date "2013-12-32"
    assert_invalid_date "2013-02-29"
  end

  test "valid date" do
    assert_valid_date ""
    assert_valid_date "2013-01-01"
    assert_valid_date "2012-02-29"
    assert_valid_date "2013-12-31"
    assert_valid_date "Jan 1, 2013"
    assert_valid_date "December 31st, 2013"
  end
end
