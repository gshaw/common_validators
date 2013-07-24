require 'test_helper'
require File.expand_path("../../app/validators/slug_format_validator",  __FILE__)

class TestModel
  include ActiveModel::Validations
  attr_accessor :slug

  validates :slug, slug_format: true
end

class SlugFormatValidatorTest < ActiveSupport::TestCase
  def assert_valid_slug(slug)
    t = TestModel.new
    t.slug = slug
    assert t.valid?, "Slug `#{slug}` should be valid"
  end

  def assert_invalid_slug(slug)
    t = TestModel.new
    t.slug = slug
    assert !t.valid?, "Slug `#{slug}` should be invalid"
  end

  test "invalid slug" do
    assert_invalid_slug "A"
    assert_invalid_slug "a b"
    assert_invalid_slug "a$"
    assert_invalid_slug "a^"
    assert_invalid_slug "a^"
  end

  test "valid slug" do
    assert_valid_slug ""
    assert_valid_slug "a"
    assert_valid_slug "1"
    assert_valid_slug "a1"
    assert_valid_slug "a-1"
    assert_valid_slug "a--1"
    assert_valid_slug "-ab"
    assert_valid_slug "ab-"
  end
end
