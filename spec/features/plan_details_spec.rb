require 'spec_helper'

feature 'Plan Details' do

  context "Tenanted" do
    before {
      Subscriptions.stub(:tenanting_enabled).and_return(true)
      Subscriptions.stub(:current_tenant).and_return( Proc.new { |request, params| 1 } )
    }
    scenario "can see details of plan in current tenant" do
      plan = FactoryGirl.create(:plan, tenant_id: 1)
      visit subscriptions.plan_path(plan)

      page.should have_content plan.name
    end
    scenario "cannot see details of plan not in current tenant" do
      plan = FactoryGirl.create(:plan, tenant_id: 2)
      visit subscriptions.plan_path(plan)

      page.should_not have_content plan.name
    end
  end

  context "Untenanted" do
    before {
      Subscriptions.stub(:tenanting_enabled).and_return(false)
    }
    scenario "can see details of a plan" do
      plan = FactoryGirl.create(:plan)
      visit subscriptions.plan_path(plan)
      page.should have_content plan.name
    end
  end

end

