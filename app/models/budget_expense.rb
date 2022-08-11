class BudgetExpense < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:expense_category, { :required => true, :class_name => "TransactionCategory", :foreign_key => "expense_category_id" })


end
