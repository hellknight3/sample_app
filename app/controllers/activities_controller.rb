class ActivitiesController < ApplicationController
  def index
    if params[:user_id]
      @activeModel=User.find(params[:user_id])
      if params[:view] == "Actions"
        @activities=Activity.where(:trackable => @activeModel)
      else
        @activities=Activity.where(:user_id => @activeModel)
      end
    end
  end
end
