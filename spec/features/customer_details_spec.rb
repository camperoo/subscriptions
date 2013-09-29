require 'spec_helper'

feature 'Customer Details' do

  context "Tenanted" do
    before {
      Subscriptions.stub(:tenanting_enabled).and_return(true)
      Subscriptions.stub(:current_tenant).and_return( Proc.new { |request, params| 1 } )
    }
    scenario "can see details of customer in current tenant" do
      customer = FactoryGirl.create(:customer, tenant_id: 1) 
      visit subscriptions.customer_path(customer)
      page.should have_content customer.email
    end
    scenario "cannot see details of customer not in current tenant" do
      customer = FactoryGirl.create(:customer, tenant_id: 2) 
      visit subscriptions.customer_path(customer)
      page.should_not have_content customer.email
    end
  end

  context "Untenanted" do
    before {
      Subscriptions.stub(:tenanting_enabled).and_return(false)
    }
    scenario "can see details of customer" do
      customer = FactoryGirl.create(:customer) 
      visit subscriptions.customer_path(customer)
      page.should have_content customer.email
    end
  end

end
