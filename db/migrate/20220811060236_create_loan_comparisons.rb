class CreateLoanComparisons < ActiveRecord::Migration[6.0]
  def change
    create_table :loan_comparisons do |t|
      t.float :apr
      t.string :lender_name
      t.float :loan_total_cost
      t.float :monthly_payments_after_school
      t.float :monthly_payments_in_school
      t.integer :repayment_period
      t.float :total_loan_amount
      t.integer :user_id

      t.timestamps
    end
  end
end
