FactoryGirl.define do

  factory :payment, class: Subscriptions::Payment do
    customer
    invoice
    amount 100
    fee 2.5
    date Date.today
    status "complete"
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
  end

end
