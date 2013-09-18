# This migration comes from subscriptions (originally 20130903184631)
class CreateSubscriptionsPlans < ActiveRecord::Migration
  def change
    create_table :subscriptions_plans do |t|
      t.string :name
      t.decimal :amount
      t.integer :interval_quantity
      t.string :interval_units
      t.integer :trial_period_days
      t.integer :assigned_id
      t.references :group, index: true

      t.timestamps
    end
  end
end
