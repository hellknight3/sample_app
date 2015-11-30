class UserSessionsController < ApplicationController
  before_action :check_if_valid, :only => [:create]
  def new
    @user_session = UserSession.new
  end
  def create
    @user_session = UserSession.new(session_params, :remember_me => false)
    if @user_session.save
        redirect_back_or go_to_home
    else
      render :new
    end
  end
  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end
  private
		def session_params
			params.require(:user_session).permit(:email, :password)
		end
        def check_if_valid
          @user=User.find_by_email(params[:user_session][:email])
          if @user.approved && !@user.verified && @user.login_count==0
            @user.verify!
          end
        end
end
