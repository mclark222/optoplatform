class TransactionCategory < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:recurring_transactions, { :class_name => "Transaction", :foreign_key => "spend_category_id", :dependent => :destroy })
  has_many(:budget_expenses, { :class_name => "BudgetExpense", :foreign_key => "expense_category_id", :dependent => :destroy })
  has_many(:budget_incomes, { :class_name => "BudgetIncome", :foreign_key => "income_category_id", :dependent => :destroy })


end
