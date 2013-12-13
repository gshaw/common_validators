require 'test_helper'
require File.expand_path("../../../app/validators/phone_number_format_validator",  __FILE__)

class TestModel
  include ActiveModel::Validations
  attr_accessor :phone_number

  validates :phone_number, phone_number_format: true
end

class PhoneNumberFormatValidatorTest < ActiveSupport::TestCase
  def assert_valid_phone_number(phone_number)
    t = TestModel.new
    t.phone_number = phone_number
    assert t.valid?, "Phone number `#{phone_number}` should be valid"
  end

  def assert_invalid_phone_number(phone_number)
    t = TestModel.new
    t.phone_number = phone_number
    refute t.valid?, "Phone number `#{phone_number}` should be invalid"
  end

  test "invalid phone_number" do
    assert_invalid_phone_number "a"
    assert_invalid_phone_number "555-1212"
    assert_invalid_phone_number "123456789"
  end

  test "valid phone_number" do
    assert_valid_phone_number ""
    assert_valid_phone_number "604-555-1212"
    assert_valid_phone_number "+1 604-555-1212"
    assert_valid_phone_number "(604) 555-1212 x1234"
    assert_valid_phone_number "604-555-1212 ext. 1234"
    assert_valid_phone_number "6045551212"
    assert_valid_phone_number "1-800-555-1212"
    assert_valid_phone_number "+1 234 567 8923"
    assert_valid_phone_number "+ 1.234.567. 89  23"
  end
end
