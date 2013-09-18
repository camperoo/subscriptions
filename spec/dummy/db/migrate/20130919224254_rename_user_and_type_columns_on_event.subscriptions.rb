# This migration comes from subscriptions (originally 20130918212228)
class RenameUserAndTypeColumnsOnEvent < ActiveRecord::Migration
  def change
    rename_column(:subscriptions_events, :user, :user_identifier)
    rename_column(:subscriptions_events, :type, :event_type)
  end
end
