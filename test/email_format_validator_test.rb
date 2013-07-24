require 'test_helper'
require File.expand_path("../../app/validators/email_format_validator",  __FILE__)

class TestModel
  include ActiveModel::Validations
  attr_accessor :email

  validates :email, email_format: true
end

class EmailFormatValidatorTest < ActiveSupport::TestCase
  def assert_valid_email(email)
    t = TestModel.new
    t.email = email
    assert t.valid?, "Email `#{email}` should be valid"
  end

  def assert_invalid_email(email)
    t = TestModel.new
    t.email = email
    assert !t.valid?, "Email `#{email}` should be invalid"
  end

  test "invalid email" do
    assert_invalid_email "foo"
    assert_invalid_email "bar@"
    assert_invalid_email " alice@example.com"
    assert_invalid_email "alice@example.com "
    assert_invalid_email "a lice@example.com"
    assert_invalid_email "alice@e xample.com"
    assert_invalid_email "alice@example.c om"
    assert_invalid_email "alice@example.c"

    # Technically these are valid email addresses but they cause Postfix to crash
    assert_invalid_email "a(lice@example.com"
    assert_invalid_email "a)lice@example.com"
    assert_invalid_email "a,lice@example.com"
    assert_invalid_email "a:lice@example.com"
    assert_invalid_email "a;lice@example.com"
    assert_invalid_email "a<lice@example.com"
    assert_invalid_email "a>lice@example.com"
    assert_invalid_email "a@lice@example.com"
    assert_invalid_email "a[lice@example.com"
    assert_invalid_email "a\\lice@example.com"
    assert_invalid_email "a]lice@example.com"
  end

  test "valid email" do
    assert_valid_email ""
    assert_valid_email "alice@example.com"
    assert_valid_email "alice@example.com"
  end
end
