class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :account_type
      t.integer :user_id
      t.integer :item_id
      t.text :name_plaid
      t.text :plaid_account_id
      t.text :mask_plaid
      t.text :official_name_plaid
      t.float :current_balance_plaid
      t.float :available_balance_plaid
      t.text :iso_currency_code_plaid
      t.text :type_plaid
      t.text :subtype_plaid
      t.integer :credit_cards_count

      t.timestamps
    end
  end
end
