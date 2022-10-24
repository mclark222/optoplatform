class CashFlowsController < ApplicationController

  def index
    matching_cash_flows = CashFlow.where({user_id: @current_user.id})

    @list_of_cash_flows = matching_cash_flows.order({ :first_day_of_week => :asc })

    render({ :template => "cash_flows/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cash_flows = CashFlow.where({ :id => the_id })

    @the_cash_flow = matching_cash_flows.at(0)

    render({ :template => "cash_flows/show.html.erb" })
  end

  def create
    the_cash_flow = CashFlow.new
    
    the_cash_flow.user_id = params.fetch("query_user_id")
    the_cash_flow.first_day_of_week = params.fetch("query_first_day_of_week")
    the_cash_flow.last_day_of_week = params.fetch("query_last_day_of_week")
    the_cash_flow.remaining_cash = params.fetch("query_remaining_cash")

    if the_cash_flow.valid?
      the_cash_flow.save
      redirect_to("/cash_flows", { :notice => "Cash flow created successfully." })
    else
      redirect_to("/cash_flows", { :alert => the_cash_flow.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cash_flow = CashFlow.where({ :id => the_id }).at(0)

    the_cash_flow.user_id = @current_user.id
    the_cash_flow.first_day_of_week = params.fetch("query_first_day_of_week")
    the_cash_flow.last_day_of_week = params.fetch("query_last_day_of_week")
    the_cash_flow.remaining_cash = params.fetch("query_remaining_cash")

    if the_cash_flow.valid?
      the_cash_flow.save

      for a_cash_flow in CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", the_cash_flow.first_day_of_week) do

              @new_min_date = a_cash_flow.first_day_of_week
    
              @new_max_date = a_cash_flow.last_day_of_week
    
              a_cash_flow.update(:remaining_cash =>
                (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
                  BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
                  BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
                    )
              )
      end

      redirect_to("/cash_flows", { :notice => "Cash flow updated successfully."} )
    else
      redirect_to("/cash_flows/", { :alert => the_cash_flow.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cash_flow = CashFlow.where({ :id => the_id }).at(0)

    the_cash_flow.destroy

    redirect_to("/cash_flows", { :notice => "Cash flow deleted successfully."} )
  end

end
