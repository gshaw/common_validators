# Validate fields to look like emails
#
# Is not an exhaustive check but prevents emails that can cause Postfix to
# crash.  Specifically emails with special characters in the local part.
#
# A blank email is considered valid (use presence validator to check for that)
#
# Examples
#   validates :email, email_format: true                 # optional
#   validates :email, email_format: true, presence: true # required
class EmailFormatValidator < ActiveModel::EachValidator
  # Local part is basically a-z 0-9 and common symbols
  # http://en.wikipedia.org/wiki/E-mail_address#Local_part
  #
  # Domain part is basically any unicode character while the TLD is still
  # restricted to at least two characters in range of a-z
  EMAIL_REGEX = /\A(([a-zA-Z0-9+_!#$%&'*+~=\/\{\}\|\`\^\?\-\.]+)@((?:[^(),:;<>@\[\\\]\s\.]+\.)+[a-z]{2,}))?\z/i

  def validate_each(record, attr_name, value)
    return if value.blank?
    record.errors.add(attr_name, :email_format, options) unless value =~ EMAIL_REGEX
  end
end
