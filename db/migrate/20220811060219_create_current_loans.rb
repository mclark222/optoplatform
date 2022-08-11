class CreateCurrentLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :current_loans do |t|
      t.float :amount_borrowed
      t.float :amount_remaining
      t.float :apr
      t.date :first_payment_date
      t.string :lender_name
      t.date :loan_start_date
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
