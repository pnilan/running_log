class UserMailer < ActionMailer::Base
  default from: "passwordreset@secondwind.co"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "SecondWind Password Reset"
  end
end
