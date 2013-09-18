require 'spec_helper'

describe Subscriptions::Invoice do

  it ".due_today" do
    invoice_tomorrow = FactoryGirl.create(:invoice, invoice_end_date: Date.today + 1)
    invoice_today1 = FactoryGirl.create(:invoice, invoice_end_date: Date.today)
    invoice_today2 = FactoryGirl.create(:invoice, invoice_end_date: Date.today)
    invoice_yesterday = FactoryGirl.create(:invoice, invoice_end_date: Date.today - 1)
    invoice_waylater = FactoryGirl.create(:invoice, invoice_end_date: Date.today + 100)

    invoices = Subscriptions::Invoice.due_today
    invoices.size.should eq(2)
    invoices.first.should eq(invoice_today1)
    invoices.last.should eq(invoice_today2)
  end


end
