class PasswordResetsController < ApplicationController
  
  def new 
  end

  def create
    @user = User.find_by(email: params[email])
    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to root_path, notice: "If your email exists in the system, we have sent a password reset email to you."
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "Your link has expired. Please try again."
  end

  def update
    @user = User.find_signed(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password was successfully reset. Please sign in."
    else
      render :edit
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
