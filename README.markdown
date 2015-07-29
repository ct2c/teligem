# Teligem

Teligem allows you to integrate the notifications of the [Telipass](https://telipass.com/) solution.

## INSTALL

In your Gemfile

```ruby
  gem 'teligem'
```

Then run 'bundle install'

## SETUP

### MODEL

When a payment has been made, Telipass sends to the notification url those parameters.
Pick the ones you are interested in and put it in your payment model.

You must at least have those attributes in your payment model: security_code:string, enduser_ip:string and ntu:string,
as they are used to check if the payment really comes from the Telipass plateform.

### RAILS SECRETS

Add to your config/secrets.yml (don't forget to add it to .gitignore)

```ruby
  telikey: "your-telipass-key"
```

## USAGE
### security_check
To check if the payment really comes from the Telipass website, set your params and call the security check method.

```ruby
  # in payment_controller.rb

  def create
    params = {
      security_code: params[:security_code],
      enduser_ip: params[:enduser_ip],
      ntu: params[:ntu]
    }

    if Telipass.new.security_check(params) do
      # ex: Create payment, give some user coins
    else
      # ex: Create payment, send a security alert
    end
  end

```
The security check method will return true if the payment really comes from Telipass, otherwise it will return false.

### check_status
Before giving coins to your user, you may want to check if the status of the transaction is valid, differed, rejected or is test.
Call the check_status function.

```ruby
  if Telipass.new.check_status(params[:status])
    # Give coins to user
  else
    # Don't give user some coins
  end
```
It will return true if status is valid, and return false if status is test or rejected or differed.

### get_earning
First, set earnings per point_name:
  ```
    Teligem::EARNING = {
      "FRSMS10" => 10,
      "FRSMS20" => 20
    }
  ```
Then call the get_earning method to the get the earning.
```
  Teligem.new.get_earning(params[:point_name])
  # It will return 10 if point_name is FRSMS10.
```
When the point_name is unknown, it will return 0.



## How to contribute?
* Fork this repository
* Create a branch to add some functionalities or solve some bugs
* Make a pull request - I will try to review and merge it asap
