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

      UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_month >= ?", the_budget_expense.first_recurrence_date).first.update(:total_expenses=> BudgetExpense.where({user_id: @current_user.id}).by_month(the_budget_expense.first_recurrence_date.year, the_budget_expense.first_recurrence_date.strftime("%B")).sum(:expense_amount))

      CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date).first.update(:remaining_cash => (
      (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date).pluck(:remaining_cash).first).to_f - (the_budget_expense.expense_amount).to_f))

      cash_flow_order_1 = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", the_budget_expense.first_recurrence_date)

      @cash_flow_order_2 = cash_flow_order_1.order({ :first_day_of_week => :asc })

      for a_cash_flow in @cash_flow_order_2 do

        @new_min_date = a_cash_flow.first_day_of_week

        @new_max_date = a_cash_flow.last_day_of_week

        a_cash_flow.update(:remaining_cash =>
          (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
              )
        )

      end


      # if the_budget_expense.recurring_frequency == 12

      #   @max_recurring_date = DateTime.new(2023,06,30)

      #   @count_of_months = ((@max_recurring_date.year * 12 + @max_recurring_date.month) - (the_budget_expense.first_recurrence_date.year * 12 + the_budget_expense.first_recurrence_date.month))

      #   @starting_date = the_budget_expense.first_recurrence_date

      #   @count_of_months.times do

      #     BudgetExpense.create(:expense_name => the_budget_expense.expense_name,:expense_amount =>the_budget_expense.expense_amount,:expense_category_id => the_budget_expense.expense_category_id, :recurring_frequency => the_budget_expense.recurring_frequency, :user_id => the_budget_expense.user_id, :first_recurrence_date => (@starting_date + 1.months))

      #     @starting_date = (@starting_date + 1.months)

      #   end

      # end

    #    <div class="col-xs-12 col-sm-2">
    #     <p><span class="show-xs font700"></span>
    #     <%= if a_budget_income.recurring_frequency == 1
    #       "One-Time"
    #     elsif a_budget_income.recurring_frequency == 52
    #       "Weekly"
    #     elsif a_budget_income.recurring_frequency == 26
    #       "Biweekly"
    #     elsif a_budget_income.recurring_frequency == 12
    #       "Monthly"
    #     elsif a_budget_income.recurring_frequency == 4
    #       "Quarterly"
    #     end %>
    #     </p>
    # </div>
      

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

      for any_user_budget in UserBudget.where({user_id: @current_user.id}) do
        
        @any_user_budget_first_day = any_user_budget.first_day_of_month

        any_user_budget.update(:total_income=> BudgetIncome.where({user_id: @current_user.id}).by_month(@any_user_budget_first_day.year, @any_user_budget_first_day.strftime("%B")).sum(:income_amount))

        any_user_budget.update(:total_expenses=> BudgetExpense.where({user_id: @current_user.id}).by_month(@any_user_budget_first_day.year, @any_user_budget_first_day.strftime("%B")).sum(:expense_amount))
      
      end

      @min_date = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date).pluck(:first_day_of_week).first

      @max_date = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date).pluck(:last_day_of_week).first

      CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date).first.update(:remaining_cash => (
            CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date - 7).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date - 7).pluck(:remaining_cash).first - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @max_date).where("first_recurrence_date >= ?", @min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @max_date).where("first_recurrence_date >= ?", @min_date).sum(:income_amount)
                  )
              )
      
      cash_flow_order_3 = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", "2022-10-23")

      @cash_flow_order_4 = cash_flow_order_3.order({ :first_day_of_week => :asc })
                
      for a_cash_flow in @cash_flow_order_4 do

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
      #, { :notice => "Budget expense updated successfully."} )
    else
      redirect_to("/budget_expenses/#{the_budget_expense.id}", { :alert => the_budget_expense.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_budget_expense = BudgetExpense.where({ :id => the_id }).at(0)

    UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_month >= ?", the_budget_expense.first_recurrence_date).first.update(:total_expenses=> 
    ((BudgetExpense.where({user_id: @current_user.id}).by_month(the_budget_expense.first_recurrence_date.year, the_budget_expense.first_recurrence_date.strftime("%B")).sum(:expense_amount) ) - the_budget_expense.expense_amount)
    )

    CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date).first.update(:remaining_cash => (
      (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_expense.first_recurrence_date).where("last_day_of_week >= ?", the_budget_expense.first_recurrence_date).pluck(:remaining_cash).first).to_f + (the_budget_expense.expense_amount).to_f))

      cash_flow_order_5 = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", "2022-10-23")

      @cash_flow_order_6 = cash_flow_order_5.order({ :first_day_of_week => :asc })
                
      for a_cash_flow in @cash_flow_order_6 do

        @new_min_date = a_cash_flow.first_day_of_week

        @new_max_date = a_cash_flow.last_day_of_week

        a_cash_flow.update(:remaining_cash =>
          (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
              )
        )
      
    end

    the_budget_expense.destroy

    redirect_to("/budget_expenses")
    #, { :notice => "Budget expense deleted successfully."} )
  end

end
