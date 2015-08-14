class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  def create
    @user_session = UserSession.new(session_params, :remember_me => false)
    if @user_session.save
      redirect_back_or go_to_home
    else
      flash[:notice]="#{@user_session.errors}"
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
end
