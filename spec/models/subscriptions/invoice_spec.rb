require 'spec_helper'

describe Subscriptions::Invoice do

  it ".due_today" do
    # invoice_tomorrow
    FactoryGirl.create(:invoice, invoice_end_date: Date.today + 1)

    # invoice_failed_1_retry
    FactoryGirl.create(:invoice, invoice_end_date: Date.today, retries: 1, status: :failed)

    # invoice_yesterday
    FactoryGirl.create(:invoice, invoice_end_date: Date.today - 1)

    # invoice_waylater
    FactoryGirl.create(:invoice, invoice_end_date: Date.today + 100)

    invoice_today1 = FactoryGirl.create(:invoice, invoice_end_date: Date.today)
    invoice_today2 = FactoryGirl.create(:invoice, invoice_end_date: Date.today)


    invoices = Subscriptions::Invoice.due_today
    invoices.size.should eq(2)
    invoices.first.should eq(invoice_today1)
    invoices.last.should eq(invoice_today2)
  end

  it ".to_retry" do
    # invoice_tomorrow
    FactoryGirl.create(:invoice, invoice_end_date: Date.today + 1)

    # invoice_today1
    FactoryGirl.create(:invoice, invoice_end_date: Date.today)

    # invoice_complete_2_retry
    FactoryGirl.create(:invoice, invoice_end_date: Date.today - 5, retries: 2, status: :complete)

    # invoice_failed_4_retry
    FactoryGirl.create(:invoice, invoice_end_date: Date.today - 4, retries: 4, status: :failed)

    invoice_failed_1_retry = FactoryGirl.create(:invoice, invoice_end_date: Date.today - 1, retries: 1, status: :failed)
    invoice_failed_2_retry = FactoryGirl.create(:invoice, invoice_end_date: Date.today - 2, retries: 2, status: :failed)

    invoices = Subscriptions::Invoice.to_retry
    invoices.size.should eq(2)

    invoices.should include(invoice_failed_1_retry)
    invoices.should include(invoice_failed_2_retry)
  end


end
