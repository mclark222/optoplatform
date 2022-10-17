class AddUserBudgetColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_budgets_count, :integer
  end
end
