# CommonValidators

[![Build Status](https://travis-ci.org/gshaw/common_validators.png?branch=master)](https://travis-ci.org/gshaw/common_validators)
[![Gem Version](https://badge.fury.io/rb/common_validators.png)](http://badge.fury.io/rb/common_validators)

Collection of common validators for Rails applications.

[RubyDoc Documentation](http://rubydoc.info/github/gshaw/common_validators/master/frames)

### Examples

```
validates :email,         email_format: true, presence: true
validates :date,          date_format: true
validates :amount,        money_format: { exclude_cents: true }
validates :phone_number,  phone_number_format: true
validates :slug,          slug_format: true
validates :url,           url_format: true
```
