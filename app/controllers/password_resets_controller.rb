class PasswordRestsController < ApplicationController
  
  def new 
  end

  def create
    @user = User.find_by(email: params[email])
    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to root_path, notice: "If your email exists in the system, we have sent a password reset email to you."
  end
end
