require 'bigdecimal'

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
class MoneyFormatValidator < ActiveModel::EachValidator
  MONEY_REGEX = /\A[-+]?\d+(\.\d{1,2})?\z/

  def validate_each(record, attr_name, value)
    if defined?(ActiveRecord::Base) && record.kind_of?(ActiveRecord::Base)
      # need to get the actual value being set because BigDecimal will convert
      # "invalid" to 0.0 making it impossible to validate
      value = record.send("#{attr_name}_before_type_cast".to_sym)
    end
    return if value.blank?

    # Need to first convert BigDecimal to floating point representation of string
    if value.kind_of?(BigDecimal)
      value = value.to_s("F")
    end

    # Finally convert any other types to string and clean off whitespace
    value = value.to_s.strip

    # Regex seems a bit odd to use here (vs converting to BigDeciaml) but we need
    # to check for values that BigDecimal can't represent (e.g., "badvalue") so
    # for now this works.
    record.errors.add(attr_name, :money_format, options) unless value =~ MONEY_REGEX

    # Check if value has cents but shouldn't
    if options[:exclude_cents] && value_has_cents?(value)
      record.errors.add(attr_name, :money_format_has_cents)
    end
  end

  def value_has_cents?(value)
    BigDecimal.new(value.to_i) != BigDecimal.new(value)
  end
end
