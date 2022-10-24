class BudgetIncomesController < ApplicationController
  def index
    matching_budget_incomes = BudgetIncome.all

    @list_of_budget_incomes = matching_budget_incomes.order({ :created_at => :desc })

    render({ :template => "budget_incomes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_budget_incomes = BudgetIncome.where({ :id => the_id })

    @the_budget_income = matching_budget_incomes.at(0)

    render({ :template => "budget_incomes/show.html.erb" })
  end

  def create
    the_budget_income = BudgetIncome.new
    the_budget_income.income_name = params.fetch("query_income_name")
    the_budget_income.income_amount = params.fetch("query_income_amount")
    the_budget_income.income_category_id = params.fetch("query_income_category_id")
    the_budget_income.first_recurrence_date = params.fetch("query_first_recurrence_date")
    the_budget_income.recurring_frequency = params.fetch("query_recurring_frequency")
    the_budget_income.user_id = params.fetch("query_user_id")

    if the_budget_income.valid?
      the_budget_income.save

      CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week > ?", the_budget_income.first_recurrence_date).first.update(:remaining_cash => (
      (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week > ?", the_budget_income.first_recurrence_date).pluck(:remaining_cash).first).to_f + (the_budget_income.income_amount).to_f))

      for a_cash_flow in CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", the_budget_income.first_recurrence_date) do

        @new_min_date = a_cash_flow.first_day_of_week

        @new_max_date = a_cash_flow.last_day_of_week

        a_cash_flow.update(:remaining_cash =>
          (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
              )
        )

      end

      redirect_to("/budget_expenses", { :notice => "Budget income created successfully." })
    else
      redirect_to("/budget_expenses", { :alert => the_budget_income.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_budget_income = BudgetIncome.where({ :id => the_id }).at(0)

    the_budget_income.income_name = params.fetch("query_income_name")
    the_budget_income.income_amount = params.fetch("query_income_amount")
    #the_budget_income.income_category_id = params.fetch("query_income_category_id")
    the_budget_income.income_category_id =
    (if params.fetch("query_income_category_id") == "Select One"
      the_budget_income.income_category_id = the_budget_income.income_category_id
    else the_budget_income.income_category_id = params.fetch("query_income_category_id")
    end)
    the_budget_income.first_recurrence_date = params.fetch("query_first_recurrence_date")
    #the_budget_income.recurring_frequency = params.fetch("query_recurring_frequency")
    the_budget_income.recurring_frequency = 
    (if params.fetch("query_recurring_frequency") == "Select One"
        the_budget_income.recurring_frequency = the_budget_income.recurring_frequency
      else the_budget_income.recurring_frequency = params.fetch("query_recurring_frequency")
      end)
    #the_budget_income.user_id = params.fetch("query_user_id")
    the_budget_income.user_id = @current_user.id 

    if the_budget_income.valid?
      the_budget_income.save

      @min_date = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).pluck(:first_day_of_week).first

      @max_date = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).pluck(:last_day_of_week).first

      CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).first.update(:remaining_cash => (
            CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date - 7).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date - 7).pluck(:remaining_cash).first - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @max_date).where("first_recurrence_date >= ?", @min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @max_date).where("first_recurrence_date >= ?", @min_date).sum(:income_amount)
                  )
              )
      
      for a_cash_flow in CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", the_budget_income.first_recurrence_date) do

          @new_min_date = a_cash_flow.first_day_of_week

          @new_max_date = a_cash_flow.last_day_of_week

          a_cash_flow.update(:remaining_cash =>
            (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
              BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
              BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
                )
          )
        
      end

      redirect_to("/budget_expenses")
      #, { :notice => "Budget income updated successfully."} )
    else
      redirect_to("/budget_incomes/#{the_budget_income.id}", { :alert => the_budget_income.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_budget_income = BudgetIncome.where({ :id => the_id }).at(0)

    the_budget_income.destroy

    redirect_to("/budget_expenses")
    #, { :notice => "Budget income deleted successfully."} )
  end
end
