class AddCodeAndCodeTextColumnsToSubscriptionEvents < ActiveRecord::Migration
  def change
    add_column(:subscriptions_events, :code, :string)
    add_column(:subscriptions_events, :code_text, :string)
  end
end
