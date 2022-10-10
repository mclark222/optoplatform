class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment line 5 in this file and line 3 in UserAuthenticationController if you want to force users to sign in before any other actions.
  before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in")
      #{ :notice => "Welcome to Opto! Please sign in or create an account to begin viewing your business school finances more clearly." })
    end
  end

  def homepage
    render({ :template => "homepage.html.erb" })
  end

  def budgeting_and_planning
    render({ :template => "homepage.html.erb" })
  end 

  def student_loans
    render({ :template => "homepage.html.erb" })
  end 
  
  def profile
    render({ :template => "homepage.html.erb" })
  end 
end
