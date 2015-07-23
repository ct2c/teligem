# Teligem

Teligem allows you to integrate the notifications of the [Telipass](https://telipass.com/) solution.

## INSTALL

In your Gemfile

  gem 'teligem'

Then run 'bundle install'

## SETUP

# MODEL

When a payment has been made, Telipass sends to the notification url those parameters.
Pick the ones you are interested in and put it in your payment model.

You must at least have those attributes: security_code:string, enduser_ip:string and ntu:string,
as they are used to check if the payment really comes from the Telipass plateform.

  # Security
  t.string :security_code               # SecurityCode
  # User Infos
  t.string :enduser_ip                  # UserIP
  t.string :enduser_host                # Userhost
  t.string :enduser_useragent           # UserAgent
  t.string :enduser_userlanguage        # Webbrowser language
  t.string :enduser_plateform           # Exploitation system
  # Transaction
  t.string :ntu, null: false            # Unique transaction number (NTU)
  t.string :module_name                 # Name of the payment module
  t.string :module_id                   # Module ID
  t.string :site_name                   # Website name
  t.string :solution_name               # Payment solution name
  t.string :payment_method              # Payment used name
  t.string :point_name                  # Point name
  t.string :country_code                # Country code name
  t.string :country_name                # Country name
  t.integer :credits                    # Credits (only for virtual money)
  t.decimal :amount                     # Commission
  t.integer :status                     # Transaction status
                                        # 1 = Valid, 2 = Rejected, 3 = Differed, 4 = Test
  t.string :status_text                 # Transaction status in text
  t.date   :transaction_date            # Transaction date
  t.string :transaction_id              # Transaction ID
  t.string :custom                      # Custom parameters

# RAILS SECRETS

Add to your config/secrets.yml. Don't forget to add it to .gitignore

development
  telikey: "your-telipass-key"

## USAGE

To check if the payment really comes from the Telipass website, just call call:

  security_check(params[:security_code], params[:enduser_ip], params[:ntu])

It will return true if the payment really comes from Telipass, otherwise it will return false.

## How to contribute?
* Fork this repository
* Create a branch to add some functionalities or solve some bugs
* Make a pull request - I will try to review and merge it asap
