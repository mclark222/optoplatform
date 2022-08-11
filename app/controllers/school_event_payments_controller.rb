class SchoolEventPaymentsController < ApplicationController
  def index
    matching_school_event_payments = SchoolEventPayment.all

    @list_of_school_event_payments = matching_school_event_payments.order({ :created_at => :desc })

    render({ :template => "school_event_payments/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_school_event_payments = SchoolEventPayment.where({ :id => the_id })

    @the_school_event_payment = matching_school_event_payments.at(0)

    render({ :template => "school_event_payments/show.html.erb" })
  end

  def create
    the_school_event_payment = SchoolEventPayment.new
    the_school_event_payment.payment_due_datetime = params.fetch("query_payment_due_datetime")
    the_school_event_payment.payment_amount = params.fetch("query_payment_amount")
    the_school_event_payment.school_event_id = params.fetch("query_school_event_id")

    if the_school_event_payment.valid?
      the_school_event_payment.save
      redirect_to("/school_event_payments", { :notice => "School event payment created successfully." })
    else
      redirect_to("/school_event_payments", { :alert => the_school_event_payment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_school_event_payment = SchoolEventPayment.where({ :id => the_id }).at(0)

    the_school_event_payment.payment_due_datetime = params.fetch("query_payment_due_datetime")
    the_school_event_payment.payment_amount = params.fetch("query_payment_amount")
    the_school_event_payment.school_event_id = params.fetch("query_school_event_id")

    if the_school_event_payment.valid?
      the_school_event_payment.save
      redirect_to("/school_event_payments/#{the_school_event_payment.id}", { :notice => "School event payment updated successfully."} )
    else
      redirect_to("/school_event_payments/#{the_school_event_payment.id}", { :alert => the_school_event_payment.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_school_event_payment = SchoolEventPayment.where({ :id => the_id }).at(0)

    the_school_event_payment.destroy

    redirect_to("/school_event_payments", { :notice => "School event payment deleted successfully."} )
  end
end
