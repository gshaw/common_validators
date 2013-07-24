# Validate fields to look like currency values
#
# NOTE: Currently limited to USD/CAD values.
#
# Includes an option to limit value to only whole dollar amounts.
#
# A blank value is considered valid (use presence validator to check for that)
#
# Examples
#   validates :amount, money_format: true                 # optional
#   validates :amount, money_format: { exclude_cents: true }
#   validates :amount, money_format: true, presence: true # required

require 'bigdecimal'

class MoneyFormatValidator < ActiveModel::EachValidator
  MONEY_REGEX = /\A[-+]?\d+(\.\d{1,2})?\z/

  def validate_each(record, attr_name, value)
    if defined?(ActiveRecord::Base) && record.kind_of?(ActiveRecord::Base)
      # need to get the actual value being set because BigDecimal will convert
      # "invalid" to 0.0 making it impossible to validate
      value = record.send("#{attr_name}_before_type_cast".to_sym)
    end
    return if value.blank?

    record.errors.add(attr_name, :money_format, options) unless value =~ MONEY_REGEX

    if options[:exclude_cents] && value_has_cents?(value)
      record.errors.add(attr_name, :money_format_whole_number)
    end
  end

  def value_has_cents?(value)
    BigDecimal.new(value.to_i) != BigDecimal.new(value)
  end
end
