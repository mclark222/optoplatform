class BudgetExpensesController < ApplicationController

  def index
    #matching_budget_expenses = BudgetExpense.all
    matching_budget_expenses = BudgetExpense.where({user_id: @current_user.id})

    @list_of_budget_expenses = matching_budget_expenses.order({ :expense_category_id => :asc })

    render({ :template => "budget_expenses/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_budget_expenses = BudgetExpense.where({ :id => the_id })

    @the_budget_expense = matching_budget_expenses.at(0)

    render({ :template => "budget_expenses/show.html.erb" })
  end

  def create
    the_budget_expense = BudgetExpense.new
    the_budget_expense.expense_name = params.fetch("query_expense_name")
    the_budget_expense.expense_amount = params.fetch("query_expense_amount")
    the_budget_expense.expense_category_id = params.fetch("query_expense_category_id")
    the_budget_expense.recurring_frequency = params.fetch("query_recurring_frequency")
    the_budget_expense.user_id = params.fetch("query_user_id")
    the_budget_expense.first_recurrence_date = params.fetch("query_first_recurrence_date")

    if the_budget_expense.valid?
      the_budget_expense.save

      UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_month > ?", the_budget_expense.first_recurrence_date).first.update(:total_expenses=> BudgetExpense.where({user_id: @current_user.id}).by_month(the_budget_expense.first_recurrence_date.year, the_budget_expense.first_recurrence_date.strftime("%B")).sum(:expense_amount))

      redirect_to("/budget_expenses")
      #, { :notice => "Budget expense created successfully." })
    else
      redirect_to("/budget_expenses", { :alert => the_budget_expense.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_budget_expense = BudgetExpense.where({ :id => the_id }).at(0)

    the_budget_expense.expense_name = params.fetch("query_expense_name")
    the_budget_expense.expense_amount = params.fetch("query_expense_amount")
    #the_budget_expense.expense_category_id = params.fetch("query_expense_category_id")
    the_budget_expense.expense_category_id =
      (if params.fetch("query_expense_category_id") == "Select One"
        the_budget_expense.expense_category_id = the_budget_expense.expense_category_id
      else the_budget_expense.expense_category_id = params.fetch("query_expense_category_id")
      end)
    #the_budget_expense.recurring_frequency = params.fetch("query_recurring_frequency")
    the_budget_expense.recurring_frequency =
      (if params.fetch("query_recurring_frequency") == "Select One"
        the_budget_expense.recurring_frequency = the_budget_expense.recurring_frequency
      else the_budget_expense.recurring_frequency = params.fetch("query_recurring_frequency")
      end)
    #the_budget_expense.user_id = params.fetch("query_user_id")
    the_budget_expense.user_id = @current_user.id
    the_budget_expense.first_recurrence_date = params.fetch("query_first_recurrence_date")

    if the_budget_expense.valid?
      the_budget_expense.save

      UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_month > ?", the_budget_expense.first_recurrence_date).first.update(:total_expenses=> BudgetExpense.where({user_id: @current_user.id}).by_month(the_budget_expense.first_recurrence_date.year, the_budget_expense.first_recurrence_date.strftime("%B")).sum(:expense_amount))

      redirect_to("/budget_expenses")
      #, { :notice => "Budget expense updated successfully."} )
    else
      redirect_to("/budget_expenses/#{the_budget_expense.id}", { :alert => the_budget_expense.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_budget_expense = BudgetExpense.where({ :id => the_id }).at(0)

    UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_month > ?", the_budget_expense.first_recurrence_date).first.update(:total_expenses=> 
    ((BudgetExpense.where({user_id: @current_user.id}).by_month(the_budget_expense.first_recurrence_date.year, the_budget_expense.first_recurrence_date.strftime("%B")).sum(:expense_amount) ) - the_budget_expense.expense_amount)
    )

    the_budget_expense.destroy

    redirect_to("/budget_expenses", { :notice => "Budget expense deleted successfully."} )
  end

end
