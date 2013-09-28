class AddTenantIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :tenant_id, :integer
  end
end
