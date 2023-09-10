class ApplyMailer < ApplicationMailer
  def applied_mail
    @user=params[:user]
    mail(to: @user.email, subject: "Applied Successfully")
  end
end
