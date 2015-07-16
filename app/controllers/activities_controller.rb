class ActivitiesController < ApplicationController
  before_action :signed_in, only: [:index]
  before_action :logged_in_director, only: [:index]
  def index
    if params[:user_id]
      @activeModel=User.find(params[:user_id])
      if params[:view] == "Actions"
        @activities=Activity.where(:trackable => @activeModel.profile)
      else
        @activities=Activity.where(:user_id => @activeModel)
      end
    end
  end
  private
  def signed_in
    unless signed_in?#checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
        store_location
        redirect_to signin_url, notice: "Please sign in."
    end
  end
  def logged_in_director
    unless is_director?
      flash[:alert]="You do not have permission to do that."
      redirect_to go_to_home
    end
  end
end
