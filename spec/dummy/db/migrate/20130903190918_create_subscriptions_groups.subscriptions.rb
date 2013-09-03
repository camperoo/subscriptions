# This migration comes from subscriptions (originally 20130903184621)
class CreateSubscriptionsGroups < ActiveRecord::Migration
  def change
    create_table :subscriptions_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
