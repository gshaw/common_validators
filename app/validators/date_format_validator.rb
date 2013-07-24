# Validate fields to be parseable dates
#
# A blank date is considered valid (use presence validator to check for that)
#
# Examples
#   validates :date, date_format: true                 # optional
#   validates :date, date_format: true, presence: true # required
class DateFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    return if value.blank?
    return if value.class == Date # if value is already Date it must be valid

    begin
      Date.parse(value)
    rescue
      record.errors.add(attr_name, :date_format, options)
    end
  end
end
