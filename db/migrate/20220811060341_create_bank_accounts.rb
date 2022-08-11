class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.float :account_balance
      t.boolean :savings_account_flag
      t.integer :asset_id
      t.string :plaid_account_id
      t.integer :account_id

      t.timestamps
    end
  end
end
