FactoryGirl.define do

  factory :payment, class: Subscriptions::Payment do
    customer
    invoice
    amount 100
    merchant_fee 10
    merchant_fee_percentage 0.1
    date Date.today
    status Subscriptions::Payment::STATUS_COMPLETE
    description "test payment"
  end

  factory :customer, class: User do |f|
    f.sequence(:email) { |n| "test#{n}@test.com" }
    password "testtest"
  end

  factory :invoice, class: Subscriptions::Invoice do
    customer
    invoice_start_date { Date.today }
    invoice_end_date { Date.today + 1.month }
    retries 0
    status Subscriptions::Invoice::STATUS_PENDING
  end

  factory :event, class: Subscriptions::Event do
    payment
    user_identifier "some@email.com"
    action "some_action"
    amount 100
    data "some data"
    event_type "some type"
    source "some source"
  end

  factory :plan, class: Subscriptions::Plan do
    name "plan name"
    amount 123.45
    interval_quantity 1
    interval_units "days"
    trial_period_days 0
  end

end
