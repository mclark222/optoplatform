class LoanDisbursementsController < ApplicationController
  def index
    matching_loan_disbursements = LoanDisbursement.all

    @list_of_loan_disbursements = matching_loan_disbursements.order({ :created_at => :desc })

    render({ :template => "loan_disbursements/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_loan_disbursements = LoanDisbursement.where({ :id => the_id })

    @the_loan_disbursement = matching_loan_disbursements.at(0)

    render({ :template => "loan_disbursements/show.html.erb" })
  end

  def create
    the_loan_disbursement = LoanDisbursement.new
    the_loan_disbursement.loan_id = params.fetch("query_loan_id")
    the_loan_disbursement.disbursement_amount = params.fetch("query_disbursement_amount")
    the_loan_disbursement.disbursement_datetime = params.fetch("query_disbursement_datetime")

    if the_loan_disbursement.valid?
      the_loan_disbursement.save
      redirect_to("/loan_disbursements", { :notice => "Loan disbursement created successfully." })
    else
      redirect_to("/loan_disbursements", { :alert => the_loan_disbursement.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_loan_disbursement = LoanDisbursement.where({ :id => the_id }).at(0)

    the_loan_disbursement.loan_id = params.fetch("query_loan_id")
    the_loan_disbursement.disbursement_amount = params.fetch("query_disbursement_amount")
    the_loan_disbursement.disbursement_datetime = params.fetch("query_disbursement_datetime")

    if the_loan_disbursement.valid?
      the_loan_disbursement.save
      redirect_to("/loan_disbursements/#{the_loan_disbursement.id}", { :notice => "Loan disbursement updated successfully."} )
    else
      redirect_to("/loan_disbursements/#{the_loan_disbursement.id}", { :alert => the_loan_disbursement.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_loan_disbursement = LoanDisbursement.where({ :id => the_id }).at(0)

    the_loan_disbursement.destroy

    redirect_to("/loan_disbursements", { :notice => "Loan disbursement deleted successfully."} )
  end
end
