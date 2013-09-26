# This migration comes from subscriptions (originally 20130926170546)
class ChangeDataFromStringToTextOnSubscriptionsInvoices < ActiveRecord::Migration
  def change
    remove_column(:subscriptions_events, :data)
    add_column(:subscriptions_events, :data, :text)
  end
end
