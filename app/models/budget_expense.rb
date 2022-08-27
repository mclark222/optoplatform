# == Schema Information
#
# Table name: budget_expenses
#
#  id                    :integer          not null, primary key
#  expense_amount        :float
#  expense_name          :string
#  first_recurrence_date :date
#  recurring_frequency   :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  expense_category_id   :integer
#  user_id               :integer
#
class BudgetExpense < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:expense_category, { :required => true, :class_name => "TransactionCategory", :foreign_key => "expense_category_id" })


end
