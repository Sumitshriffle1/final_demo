class UserMailer < ApplicationMailer
  def token_email
    @user=params[:user]
    mail(to: @user.email, subject: "Token Email")
  end
end
