class LoanComparisonsController < ApplicationController
  def index
    matching_loan_comparisons = LoanComparison.all

    @list_of_loan_comparisons = matching_loan_comparisons.order({ :created_at => :desc })

    render({ :template => "loan_comparisons/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_loan_comparisons = LoanComparison.where({ :id => the_id })

    @the_loan_comparison = matching_loan_comparisons.at(0)

    render({ :template => "loan_comparisons/show.html.erb" })
  end

  def create
    the_loan_comparison = LoanComparison.new
    the_loan_comparison.apr = params.fetch("query_apr")
    the_loan_comparison.lender_name = params.fetch("query_lender_name")
    the_loan_comparison.loan_total_cost = params.fetch("query_loan_total_cost")
    the_loan_comparison.monthly_payments_after_school = params.fetch("query_monthly_payments_after_school")
    the_loan_comparison.monthly_payments_in_school = params.fetch("query_monthly_payments_in_school")
    the_loan_comparison.repayment_period = params.fetch("query_repayment_period")
    the_loan_comparison.total_loan_amount = params.fetch("query_total_loan_amount")
    the_loan_comparison.user_id = params.fetch("query_user_id")

    if the_loan_comparison.valid?
      the_loan_comparison.save
      redirect_to("/loan_comparisons", { :notice => "Loan comparison created successfully." })
    else
      redirect_to("/loan_comparisons", { :alert => the_loan_comparison.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_loan_comparison = LoanComparison.where({ :id => the_id }).at(0)

    the_loan_comparison.apr = params.fetch("query_apr")
    the_loan_comparison.lender_name = params.fetch("query_lender_name")
    the_loan_comparison.loan_total_cost = params.fetch("query_loan_total_cost")
    the_loan_comparison.monthly_payments_after_school = params.fetch("query_monthly_payments_after_school")
    the_loan_comparison.monthly_payments_in_school = params.fetch("query_monthly_payments_in_school")
    the_loan_comparison.repayment_period = params.fetch("query_repayment_period")
    the_loan_comparison.total_loan_amount = params.fetch("query_total_loan_amount")
    the_loan_comparison.user_id = params.fetch("query_user_id")

    if the_loan_comparison.valid?
      the_loan_comparison.save
      redirect_to("/loan_comparisons/#{the_loan_comparison.id}", { :notice => "Loan comparison updated successfully."} )
    else
      redirect_to("/loan_comparisons/#{the_loan_comparison.id}", { :alert => the_loan_comparison.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_loan_comparison = LoanComparison.where({ :id => the_id }).at(0)

    the_loan_comparison.destroy

    redirect_to("/loan_comparisons", { :notice => "Loan comparison deleted successfully."} )
  end
end
