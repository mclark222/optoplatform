class CreateUserBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :user_budgets do |t|
      t.integer :user_id
      t.date :first_day_of_month
      t.date :last_day_of_month
      t.float :non_school_expenses
      t.float :required_school_expenses
      t.float :optional_school_expenses
      t.float :total_expenses
      t.float :total_income

      t.timestamps
    end
  end
end
