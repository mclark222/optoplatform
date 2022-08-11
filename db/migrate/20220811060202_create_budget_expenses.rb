class CreateBudgetExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :budget_expenses do |t|
      t.string :expense_name
      t.float :expense_amount
      t.integer :expense_category_id
      t.integer :recurring_frequency
      t.integer :user_id
      t.date :first_recurrence_date

      t.timestamps
    end
  end
end
