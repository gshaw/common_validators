# CommonValidators

[![Build Status](https://travis-ci.org/gshaw/common_validators.png?branch=master)](https://travis-ci.org/gshaw/common_validators)
[![Gem Version](https://badge.fury.io/rb/common_validators.png)](http://badge.fury.io/rb/common_validators)

Collection of common validators for Rails applications.

[RubyDoc Documentation](http://rubydoc.info/github/gshaw/common_validators/master/frames)

## Usage

In your ActiveRecord models include one more validations on your model's fields.

    validates :email,         email_format: true, presence: true
    validates :date,          date_format: true
    validates :amount,        money_format: { exclude_cents: true }
    validates :phone_number,  phone_number_format: true
    validates :slug,          slug_format: true
    validates :url,           url_format: true

## Installation

Add this line to your application's Gemfile:

    gem 'venture_base'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install venture_base

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
