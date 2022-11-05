class UserAuthenticationController < ApplicationController
  # Uncomment line 3 in this file and line 5 in ApplicationController if you want to force users to sign in before any other actions.
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie, :forgot_password, :forgot_password_create] })

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first

    the_supplied_password = params.fetch("query_password")

    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)

      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id

        redirect_to("/")
        #{ :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/")
    #, { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.graduation_date = params.fetch("query_graduation_date")
    @user.school = params.fetch("query_school")
    @user.international_student_status = params.fetch("query_international_student_status", false)
    @user.premba_industry = params.fetch("query_premba_industry")
    @user.gender = params.fetch("query_gender")
    @user.birth_date = params.fetch("query_birth_date")

    # @user.loan_comparisons_count = params.fetch("query_loan_comparisons_count")
    # @user.spend_intentions_count = params.fetch("query_spend_intentions_count")
    # @user.accounts_count = params.fetch("query_accounts_count")
    # @user.budget_expenses_count = params.fetch("query_budget_expenses_count")
    # @user.budget_incomes_count = params.fetch("query_budget_incomes_count")
    # @user.current_loans_count = params.fetch("query_current_loans_count")
    # @user.transaction_categories_count = params.fetch("query_transaction_categories_count")
    # @user.school_events_count = params.fetch("query_school_events_count")
    # @user.plaid_items_count = params.fetch("query_plaid_items_count")

    @user.loan_comparisons_count = "0"
    @user.spend_intentions_count = "0"
    @user.accounts_count = "0"
    @user.budget_expenses_count = "0"
    @user.budget_incomes_count = "0"
    @user.current_loans_count = "0"
    @user.transaction_categories_count = "0"
    @user.school_events_count = "0"
    @user.plaid_items_count = "0"
    @user.user_budgets_count = "0"
    @user.cash_flows_count = "0"

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id

      #UserMailer.account_activation(@user).deliver_now         #need to figure out how to get this working

      redirect_to("/home")
      #, { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => @user.errors.full_messages.to_sentence })
    end
  end

  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.graduation_date = params.fetch("query_graduation_date")
    #@user.school = params.fetch("query_school")
    @user.school =
      (if params.fetch("query_school") == "Select One"
        @user.school = @user.school
      else @user.school = params.fetch("query_school")       end)
    #@user.international_student_status = params.fetch("query_international_student_status", false)
    @user.international_student_status =
      (if params.fetch("query_international_student_status") == "Select One"
        @user.international_student_status = @user.international_student_status
      else @user.international_student_status = params.fetch("query_international_student_status")       end)
    #@user.premba_industry = params.fetch("query_premba_industry")
    @user.premba_industry =
      (if params.fetch("query_premba_industry") == "Select One"
        @user.premba_industry = @user.premba_industry
      else @user.premba_industry = params.fetch("query_premba_industry")       end)
    #@user.gender = params.fetch("query_gender")
    @user.gender =
      (if params.fetch("query_gender") == "Select One"
        @user.gender = @user.gender
      else @user.gender = params.fetch("query_gender")       end)

    @user.birth_date = params.fetch("query_birth_date")

    #The below fields are hidden because a user shouldn't be updating them directly. But I would ensure that we still have a way to update them.

    @user.loan_comparisons_count = @current_user.loan_comparisons_count
    @user.spend_intentions_count = @current_user.spend_intentions_count
    @user.accounts_count = @current_user.accounts_count
    @user.budget_expenses_count = @current_user.budget_expenses_count
    @user.budget_incomes_count = @current_user.budget_incomes_count
    @user.current_loans_count = @current_user.current_loans_count
    @user.transaction_categories_count = @current_user.transaction_categories_count
    @user.school_events_count = @current_user.school_events_count
    @user.plaid_items_count = @current_user.plaid_items_count
    @user.user_budgets_count = @current_user.user_budgets_count
    @user.cash_flows_count = @current_user.cash_flows_count

    # @user.loan_comparisons_count = params.fetch("query_loan_comparisons_count")
    # @user.spend_intentions_count = params.fetch("query_spend_intentions_count")
    # @user.accounts_count = params.fetch("query_accounts_count")
    # @user.budget_expenses_count = params.fetch("query_budget_expenses_count")
    # @user.budget_incomes_count = params.fetch("query_budget_incomes_count")
    # @user.current_loans_count = params.fetch("query_current_loans_count")
    # @user.transaction_categories_count = params.fetch("query_transaction_categories_count")
    # @user.school_events_count = params.fetch("query_school_events_count")
    # @user.plaid_items_count = params.fetch("query_plaid_items_count")

    if @user.valid?
      @user.save

      redirect_to("/home")
      #, { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb", :alert => @user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    @current_user.destroy
    reset_session

    redirect_to("/home")
    #,{ :notice => "User account cancelled" })
  end

  def forgot_password
  end

  def forgot_password_create
    @user = User.where({ :email => params.fetch("query_email") }).first

    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to root_path, notice: "If your email exists in the system, we have sent a password reset email to you."
  end

  def forgot_password_edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "Your link has expired. Please try again."
  end
end

def forgot_password_update
  @user = User.find_signed(params[:token], purpose: "password_reset")
  if @user.update(password_params)
    redirect_to sign_in_path, notice: "Your password was successfully reset. Please sign in."
  else
    render :edit
  end

  private

  def forgot_password_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
