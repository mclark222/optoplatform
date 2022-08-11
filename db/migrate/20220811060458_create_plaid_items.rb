class CreatePlaidItems < ActiveRecord::Migration[6.0]
  def change
    create_table :plaid_items do |t|
      t.integer :user_id
      t.text :plaid_access_token
      t.text :plaid_item_id
      t.text :plaid_institution_id
      t.text :status
      t.text :transactions_cursor
      t.integer :accounts_count

      t.timestamps
    end
  end
end
