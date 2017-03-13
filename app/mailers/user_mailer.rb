class UserMailer < ApplicationMailer

  def signup_mail(user:)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Cash Counter!')
  end

end
