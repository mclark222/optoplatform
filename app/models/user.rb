class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:loan_comparisons, { :class_name => "LoanComparison", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:spend_intentions, { :class_name => "SpendIntention", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:accounts, { :class_name => "Account", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:budget_expenses, { :class_name => "BudgetExpense", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:budget_incomes, { :class_name => "BudgetIncome", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:current_loans, { :class_name => "CurrentLoan", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:transaction_categories, { :class_name => "TransactionCategory", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:school_events, { :class_name => "SchoolEvent", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:plaid_items, { :class_name => "PlaidItem", :foreign_key => "user_id", :dependent => :destroy })

end
