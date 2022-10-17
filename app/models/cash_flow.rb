# == Schema Information
#
# Table name: cash_flows
#
#  id                :integer          not null, primary key
#  first_day_of_week :date
#  last_day_of_week  :date
#  remaining_cash    :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
class CashFlow < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  
end
