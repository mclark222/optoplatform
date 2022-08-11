class CreateBudgetIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :budget_incomes do |t|
      t.string :income_name
      t.float :income_amount
      t.integer :income_category_id
      t.date :first_recurrence_date
      t.integer :recurring_frequency
      t.integer :user_id

      t.timestamps
    end
  end
end
