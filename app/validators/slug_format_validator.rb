# Validate fields to be slugs
#
# A slug must only contain lowercase a-z, digits 0-9 or dashes -
#
# A blank slug is considered valid (use presence validator to check for that)
#
# Examples
#   validates :slug, slug_format: true                 # optional
#   validates :slug, slug_format: true, presence: true # required
class SlugFormatValidator < ActiveModel::EachValidator
  SLUG_REGEX = /\A[a-z0-9-]+\z/

  def validate_each(record, attr_name, value)
    return if value.blank?
    record.errors.add(attr_name, :slug_format, options) unless value =~ SLUG_REGEX
  end
end
