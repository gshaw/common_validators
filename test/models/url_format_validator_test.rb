require 'test_helper'
require File.expand_path("../../../app/validators/url_format_validator",  __FILE__)

class TestModel
  include ActiveModel::Validations
  attr_accessor :url

  validates :url, url_format: true
end

class UrlFormatValidatorTest < ActiveSupport::TestCase
  def assert_valid_url(url)
    t = TestModel.new
    t.url = url
    assert t.valid?, "Url `#{url}` should be valid"
  end

  def assert_invalid_url(url)
    t = TestModel.new
    t.url = url
    refute t.valid?, "Url `#{url}` should be invalid"
  end

  test "invalid url" do
    assert_invalid_url "h ttp://example.com"
    assert_invalid_url "http://examp\\"
    assert_invalid_url "bad://example.com"
    assert_invalid_url "://example.com"
    assert_invalid_url "//example.com"
  end

  test "valid url" do
    assert_valid_url ""
    assert_valid_url "http://example.com"
    assert_valid_url "HTTP://example.com"
    assert_valid_url "https://example.com"
    assert_valid_url "http://example.com/foo/bar"
    assert_valid_url "http://example.com/foo/bar?a=b&c=d"
  end
end
