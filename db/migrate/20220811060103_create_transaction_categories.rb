class CreateTransactionCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_categories do |t|
      t.string :spend_category_name
      t.integer :user_id
      t.string :spend_sub_category
      t.text :spend_sub_category_details

      t.timestamps
    end
  end
end
