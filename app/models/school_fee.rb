# == Schema Information
#
# Table name: school_fees
#
#  id             :integer          not null, primary key
#  fee_amount     :float
#  fee_name       :string
#  first_fee_date :datetime
#  school         :string
#  term           :string
#  year           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class SchoolFee < ApplicationRecord
end
