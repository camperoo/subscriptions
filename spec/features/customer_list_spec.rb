require 'spec_helper'

feature 'Customer List' do

  context "Tenanted" do

    before {
      Subscriptions.stub(:tenanting_enabled).and_return(true)
      Subscriptions.stub(:current_tenant).and_return( Proc.new { |request, params| 1 } )
    }
    scenario "Pulling up page shows all customers" do
      customer1 = FactoryGirl.create(:customer, tenant_id: 1) 
      customer2 = FactoryGirl.create(:customer, tenant_id: 2) 
      visit '/subscriptions/customers'
      expect(page).to have_content customer1.email
      expect(page).to_not have_content customer2.email
    end
  end

  context "Untenanted" do
    before {
      Subscriptions.stub(:tenanting_enabled).and_return(false)
    }
    scenario "Pulling up page shows all customers" do
      customer1 = FactoryGirl.create(:customer) 
      customer2 = FactoryGirl.create(:customer) 
      visit '/subscriptions/customers'
      expect(page).to have_content customer1.email
      expect(page).to have_content customer2.email
    end
  end
end
