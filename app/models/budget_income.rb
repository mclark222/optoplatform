# == Schema Information
#
# Table name: budget_incomes
#
#  id                    :integer          not null, primary key
#  first_recurrence_date :date
#  income_amount         :float
#  income_name           :string
#  recurring_frequency   :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  income_category_id    :integer
#  user_id               :integer
#
class BudgetIncome < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:income_category, { :required => true, :class_name => "TransactionCategory", :foreign_key => "income_category_id" })


end
