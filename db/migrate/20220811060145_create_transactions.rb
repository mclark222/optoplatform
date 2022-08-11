class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.text :name_plaid
      t.float :transaction_amount
      t.datetime :transaction_datetime
      t.integer :recurring_frequency
      t.date :recurring_end_date
      t.integer :spend_category_id
      t.boolean :income_flag
      t.boolean :recurring_flag
      t.text :iso_currency_code
      t.string :merchant_name
      t.string :payment_channel
      t.text :transaction_category_plaid
      t.datetime :authorized_datetime
      t.string :transaction_location
      t.text :transaction_subcategory_plaid
      t.integer :account_id
      t.text :plaid_transaction_id
      t.text :plaid_category_id
      t.text :type_plaid
      t.boolean :pending

      t.timestamps
    end
  end
end
