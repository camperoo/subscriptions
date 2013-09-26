subscriptions
=============

Subscriptions is a subscription-billing engine for Ruby on Rails. Think Chargify or Stripe, but as a mountable engine where:

1. you provide your own payment provider
2. you don't have to do any API integration
3. it's open source
4. there are NO FEES
5. it supports multiple groups/tenants

In addition to subscription billing, you can also do adhoc invoicing, where you charge users an arbitrary amount in the
future, once you have their payment credentials.

Status
------

This project is currently a work in progress. Right now you can do Adhoc Invoicing as described below. Subscription billing
is in the works.

Dependencies
------------

Subscriptions depends on active_merchant to communicate with the payment gateway. Subscriptions currently only supports the 
Authorize.NET CIM gateway. You'll need to have an Authorize.NET account with CIM activated. Then you'll need your API key 
and password.

Installation
------------

Add the following to your Gemfile and run bundle:

```gem 'subscriptions'```

Generate and run the database migrations in your project:

```
rake subscriptions:install:migrations
rake db:migrate
```

Create an initializer in ```config/initializers/subscriptions.rb``` with the following code:

```
Subscriptions.customer_class = "User" # where the string represents the name of your User class
```

Finally, you'll have to modify your user model and add the following:

```
has_many :invoices, class_name: "Subscriptions::Invoice"
has_many :payments, class_name: "Subscriptions::Payment"
has_one :credit_card, class_name: "Subscriptions::CreditCard"
```



Terminology
-----------
- **Adhoc Invoicing** - Charging a user an arbitrary amount of money at some point in the future (as opposed to Subscription Invoicing)
- **Credit Card** - Holds the Authorize.NET payment profile information (not the actual card number)
- **Customer Profile ID** - The Authorize.NET ID that represents the customer
- **Invoice** - Represents who, when, and how much to charge.
- **Payment Profile ID** - The Authorize.NET ID that represents the credit card information for the customer
- **Plan** - Defines a recurring payment plan (how much to charge and on what interval)
- **Subscription Invoicing** - Charging a user based on a specific plan.


Obtaining the Authorize.NET CIM profile information
---------------------------------------------------

In order to process a credit card, you first have to obtain a Customer Profile ID and a Payment Profile ID. You can
do this using Authorize.NET CIM in several different ways.

More details coming soon...


Adhoc Invoicing
---------------

First, you'll have to create a credit card
```
# Create a credit card
credit_card = Subscriptions::CreditCard.new
credit_card.customer = current_user
credit_card.customer_profile_id = [Authorize.NET CIM Customer Profile ID]
credit_card.customer_payment_profile_id = [Authorize.NET CIM Payment Profile ID]
```

Then you'll have to create an invoice
```
# Create an invoice
invoice = Subscriptions::Invoice.new
invoice.invoice_start_date = Date.today
invoice.invoice_end_date = Date.today + 45
invoice.customer = current_user
invoice.amount = 99.99

generate_credit_card_from_source(pay_source)
invoice.save!
```

Processing Invoices
-------------------
In order to actually charge on your invoices, you'll need to set up a 
background process that will iterate over all your invoices and charge
them. First set up a worker called ```app/workers/payment_worker.rb```. 
Using Sidekiq for background processing, the worker might look like this:

```
require "active_merchant"

class PaymentWorker
  include Sidekiq::Worker

  def perform(invoice_id)

    unless Rails.env == "production"
      ActiveMerchant::Billing::Base.mode = :test
    end

    gateway = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
      login: [LOGIN GOES HERE]
      password: [PASSWORD GOES HERE]
    )

    payment_gateway = Subscriptions::PaymentGateway.new(gateway)
    bill_collector = Subscriptions::BillCollector.new(payment_gateway)

    due_invoice = Subscriptions::Invoice.find(invoice_id)

    bill_collector.collect(due_invoice)
  end

end
```

Then you can create a rake task that you can call from a cron job. You can
put this in a file called ```lib/tasks/subscriptions.rake```

```
require_relative '../../app/workers/payment_worker'

desc "This task is called by a cron scheduler"

namespace :subscriptions do
  task :process_invoices_due_today => :environment do
    puts "Looking up invoices due today #{Time.now.strftime("%b %d, %Y")}"

    due_invoices = Subscriptions::Invoice.due_today
    process_invoices(due_invoices, "due today")

    invoices_to_retry = Subscriptions::Invoice.to_retry
    process_invoices(invoices_to_retry, "to retry")
  end

  def process_invoices(invoices, message)
    if invoices.empty?
      puts "No invoices #{message} found."
      return
    end

    invoice_str = "invoice".pluralize(invoices.size)
    puts "Found #{invoices.size} #{invoice_str} #{message}, processing..."
    invoices.each do |invoice|
      PaymentWorker.perform_async(invoice.id)
    end
  end
end

```
