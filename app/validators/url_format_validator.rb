# Validate fields to look like URLs
#
# A blank URL is considered valid (use presence validator to check for that)
#
# Examples
#   validates :url, url_format: true                 # optional
#   validates :url, url_format: true, presence: true # required
class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    return if value.blank?

    valid = begin
      URI.parse(value).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
    record.errors.add(attr_name, :url_format, options) unless valid
  end
 end
