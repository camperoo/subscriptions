require 'spec_helper'

feature 'Customer List' do

  given!(:customer1) { FactoryGirl.create(:customer) }
  given!(:customer2) { FactoryGirl.create(:customer) }

  scenario "Pulling up page shows all customers" do
    visit '/subscriptions/customers'
    expect(page).to have_content customer1.email
    expect(page).to have_content customer2.email
  end

end
