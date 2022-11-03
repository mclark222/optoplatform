class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[email])
    if @user present?
      PasswordMailer.with(user:@user).reset.defliver_now
    end
    redirect_to root_path, notice: "If your email exists in our system, we have sent a password reset link."
  end
end
