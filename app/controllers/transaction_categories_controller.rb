class TransactionCategoriesController < ApplicationController
  def index
    matching_transaction_categories = TransactionCategory.all

    @list_of_transaction_categories = matching_transaction_categories.order({ :created_at => :desc })

    render({ :template => "transaction_categories/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_transaction_categories = TransactionCategory.where({ :id => the_id })

    @the_transaction_category = matching_transaction_categories.at(0)

    render({ :template => "transaction_categories/show.html.erb" })
  end

  def create
    the_transaction_category = TransactionCategory.new
    the_transaction_category.spend_category_name = params.fetch("query_spend_category_name")
    the_transaction_category.user_id = params.fetch("query_user_id")
    the_transaction_category.spend_sub_category = params.fetch("query_spend_sub_category")
    the_transaction_category.spend_sub_category_details = params.fetch("query_spend_sub_category_details")

    if the_transaction_category.valid?
      the_transaction_category.save
      redirect_to("/transaction_categories", { :notice => "Transaction category created successfully." })
    else
      redirect_to("/transaction_categories", { :alert => the_transaction_category.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_transaction_category = TransactionCategory.where({ :id => the_id }).at(0)

    the_transaction_category.spend_category_name = params.fetch("query_spend_category_name")
    the_transaction_category.user_id = params.fetch("query_user_id")
    the_transaction_category.spend_sub_category = params.fetch("query_spend_sub_category")
    the_transaction_category.spend_sub_category_details = params.fetch("query_spend_sub_category_details")

    if the_transaction_category.valid?
      the_transaction_category.save
      redirect_to("/transaction_categories/#{the_transaction_category.id}", { :notice => "Transaction category updated successfully."} )
    else
      redirect_to("/transaction_categories/#{the_transaction_category.id}", { :alert => the_transaction_category.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_transaction_category = TransactionCategory.where({ :id => the_id }).at(0)

    the_transaction_category.destroy

    redirect_to("/transaction_categories", { :notice => "Transaction category deleted successfully."} )
  end
end
