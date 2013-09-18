binding.pry

FactoryGirl.define do
  factory :payment do
    customer
    invoice
    amount 100
    gateway_fee 2.5
    gateway_fee_percentage 0.025
    merchant_fee 2.5
    merchant_fee_percentage 0.025
    date Date.today
    status "complete"
    description "test payment"
  end

  factory :customer, class: Subscription.customer_class do

  end

  factory :invoice do
    customer
    invoice_start_date { Date.today }
    invoice_end_date { Date.today + 1.month }
  end

end
