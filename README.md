# CommonValidators

Collection of common validators for Rails applications.

## Validators

```
validates :email,         email_format: true, presence: true
validates :date,          date_format: true
validates :amount,        money_format: { exclude_cents: true }
validates :phone_number,  phone_number_format: true
validates :slug,          slug_format: true
validates :url,           url_format: true
```
