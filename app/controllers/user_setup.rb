class UserSetupController < ApplicationController

  def create_expense_categories
    @user = user

    TransactionCategory.create(:query_spend_category_name=>'Auto & Transportation',:query_user_id=>user.id,:query_spend_sub_category=>'General',:query_spend_sub_category_details=>'Misc. budget items')
    TransactionCategory.create(:query_spend_category_name=>'Bills & Utilities',:query_user_id=>user.id,:query_spend_sub_category=>'General',:query_spend_sub_category_details=>'Misc. budget items')

  #  TransactionCategory.create(:query_spend_category_name=>'',:query_user_id=>user.id,:query_spend_sub_category=>'',:query_spend_sub_category_details=>'')
  
    #  <action="/insert_user" method="post">
  
  end

end
