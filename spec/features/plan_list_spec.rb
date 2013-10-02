require 'spec_helper'

feature 'Plans List' do

  context "Tenanted" do

    before {
      Subscriptions.stub(:tenanting_enabled).and_return(true)
      Subscriptions.stub(:current_tenant).and_return( Proc.new { |request, params| 1 } )
    }

    scenario "Pulling up page shows only plans for tenants" do
      plan1 = FactoryGirl.create(:plan, name: "plan 1",
                                 interval_quantity: 1,
                                 tenant_id: 1)

      plan2 = FactoryGirl.create(:plan, name: "plan 2",
                                 interval_quantity: 2,
                                 tenant_id: 2)

      visit plans_path

      page.should have_link plan1.name
      page.should have_content plan1.description

      page.should_not have_link plan2.name
      page.should_not have_content plan2.description
    end
  end

  context "Untenanted" do
    before {
      Subscriptions.stub(:tenanting_enabled).and_return(false)
    }

    scenario "Pulling up page shows all plans" do
      plan1 = FactoryGirl.create(:plan, name: "plan 1", interval_quantity: 1)
      plan2 = FactoryGirl.create(:plan, name: "plan 2", interval_quantity: 2)

      visit plans_path

      page.should have_link plan1.name
      page.should have_content plan1.description

      page.should have_link plan2.name
      page.should have_content plan2.description
    end
  end
end

