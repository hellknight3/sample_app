module ActivitiesHelper
    def isProfile?(string)
      string == "Admin" || string == "Doctor" || string == "Patient"
    end
    def userActivitiesButton
      if params[:view]=="Actions"
"btn btn-default btn-inactive"
      elsif params[:view]=="Activity" || params[:view].nil?
        "btn btn-default btn-primary"
      end
    end
  def userActionsButton
      if params[:view]=="Actions"
"btn btn-default btn-primary"
      elsif params[:view]=="Activity" || params[:view].nil?
        "btn btn-default" 
      end
    end

end
