class AddCashFlowsCountColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cash_flows_count, :integer
  end
end
