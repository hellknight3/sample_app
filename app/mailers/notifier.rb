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

  def invitation_instructions(user,temp_password)
    @user = user
    @temp_password=temp_password
    mail(to: @user.email,
    subject: "Invitation to a new app!") do |format|
      format.html {render 'invitation_instructions' }
    end
  end


end
