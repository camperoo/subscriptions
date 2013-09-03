class CreateSubscriptionsGroups < ActiveRecord::Migration
  def change
    create_table :subscriptions_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
