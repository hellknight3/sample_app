class ApplicationController < ActionController::Base
  #self.responder = ApplicationResponder
  helper_method :current_user_session, :current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end
  private
    def current_user_session
      @current_user_session ||= UserSession.find
    end

    def current_user
      @current_user ||= current_user_session && current_user_session.user
    end

end
