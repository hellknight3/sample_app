module InstitutionHelper
  def isOtherInstitution
    if params[:institution] == "Other"
      "btn btn-info"
    else
      "btn btn-default"
    end
  end
  def isMyInstitution
    if params[:institution].nil? || params[:institution]=="My" 
      "btn btn-info"
    else
      "btn btn-default"
    end
  end
end
