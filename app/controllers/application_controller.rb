class ApplicationController < ActionController::Base
  def homepage
    render({ :template => "homepage.html.erb" })
  end

  def budgeting_and_planning
    render({ :template => "homepage.html.erb" })
  end 

  def student_loans
    render({ :template => "homepage.html.erb" })
  end 
end
