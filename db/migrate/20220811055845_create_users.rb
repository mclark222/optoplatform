class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.date :graduation_date
      t.string :school
      t.boolean :international_student_status
      t.string :premba_industry
      t.string :gender
      t.date :birth_date
      t.integer :loan_comparisons_count
      t.integer :spend_intentions_count
      t.integer :accounts_count
      t.integer :budget_expenses_count
      t.integer :budget_incomes_count
      t.integer :current_loans_count
      t.integer :transaction_categories_count
      t.integer :school_events_count
      t.integer :plaid_items_count

      t.timestamps
    end
  end
end
