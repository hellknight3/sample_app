class ActivitiesController < ApplicationController
  def index
  end
  def create
    Activity.new(activity_params)
    if @activity.save
    end
  end
end
