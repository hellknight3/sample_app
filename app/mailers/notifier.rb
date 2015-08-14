class Notifier < ActionMailer::Base
  default from: ENV["gmail_username"]
  default_url_options[:host]= "www.myurl.org"
  def verification_instructions(user)
    @user = user
    @verification_url = user_verification_url(user.perishable_token)
    mail(to: @user.email,
    subject: "Email Verification") do |format|
      format.html {render 'verification_instructions' }
    end
  end

end
