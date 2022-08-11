class SchoolFeesController < ApplicationController
  def index
    matching_school_fees = SchoolFee.all

    @list_of_school_fees = matching_school_fees.order({ :created_at => :desc })

    render({ :template => "school_fees/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_school_fees = SchoolFee.where({ :id => the_id })

    @the_school_fee = matching_school_fees.at(0)

    render({ :template => "school_fees/show.html.erb" })
  end

  def create
    the_school_fee = SchoolFee.new
    the_school_fee.fee_name = params.fetch("query_fee_name")
    the_school_fee.first_fee_date = params.fetch("query_first_fee_date")
    the_school_fee.school = params.fetch("query_school")
    the_school_fee.fee_amount = params.fetch("query_fee_amount")
    the_school_fee.term = params.fetch("query_term")
    the_school_fee.year = params.fetch("query_year")

    if the_school_fee.valid?
      the_school_fee.save
      redirect_to("/school_fees", { :notice => "School fee created successfully." })
    else
      redirect_to("/school_fees", { :alert => the_school_fee.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_school_fee = SchoolFee.where({ :id => the_id }).at(0)

    the_school_fee.fee_name = params.fetch("query_fee_name")
    the_school_fee.first_fee_date = params.fetch("query_first_fee_date")
    the_school_fee.school = params.fetch("query_school")
    the_school_fee.fee_amount = params.fetch("query_fee_amount")
    the_school_fee.term = params.fetch("query_term")
    the_school_fee.year = params.fetch("query_year")

    if the_school_fee.valid?
      the_school_fee.save
      redirect_to("/school_fees/#{the_school_fee.id}", { :notice => "School fee updated successfully."} )
    else
      redirect_to("/school_fees/#{the_school_fee.id}", { :alert => the_school_fee.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_school_fee = SchoolFee.where({ :id => the_id }).at(0)

    the_school_fee.destroy

    redirect_to("/school_fees", { :notice => "School fee deleted successfully."} )
  end
end
