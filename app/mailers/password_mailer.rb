class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pasword_mailer.reset.subject
  #
  def reset
    @token = params[:user].signed_id(purpose: "password_reset", expires_in: 15.minutes)

    mail to: params[:user].email
  end

  def send_reset_email
    mail( :to => params[:user].email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

end
