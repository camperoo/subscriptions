class ChangeDataFromStringToTextOnSubscriptionsInvoices < ActiveRecord::Migration
  def change
    remove_column(:subscriptions_events, :data)
    add_column(:subscriptions_events, :data, :text)
  end
end
