Rails.application.routes.draw do

  get("/home", { :controller => "application", :action => "homepage" })
  #get("/budgeting-and-planning", { :controller => "application", :action => "budgeting_and_planning" })
  #get("/student-loans", { :controller => "application", :action => "student_loans" })
end
