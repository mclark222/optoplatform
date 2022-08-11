class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.float :apr
      t.string :card_name
      t.float :credit_line
      t.float :current_balance
      t.float :minimum_payment
      t.date :payment_date
      t.date :statement_start_date
      t.string :plaid_account_id
      t.integer :account_id

      t.timestamps
    end
  end
end
