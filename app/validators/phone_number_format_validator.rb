# Validate fields to look like phone numbers
#
# Is not an exhaustive check, works by stripping all non-digits out and looking
# for a string with at least 10 digits.
#
# A blank phone number is considered valid (use presence validator to check for that)
#
# Examples
#   validates :phone_number, phone_number_format: true                 # optional
#   validates :phone_number, phone_number_format: true, presence: true # required

class PhoneNumberFormatValidator < ActiveModel::EachValidator
  # http://stackoverflow.com/a/123681/265940
  PHONE_NUMBER_REGEX = /\A[ \d\+\-\(\)ext\.\/]{10,}\z/i

  def validate_each(record, attr_name, value)
    return if value.blank?
    record.errors.add(attr_name, :phone_number_format, options) unless value =~ PHONE_NUMBER_REGEX
  end
end
