module PatientsHelper
	def personalPage
		if ( params[:info_type] == "Personal" || params[:info_type].nil?)
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def doctorsPage
		if ( params[:info_type] == "Doctors")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def accountSettings
		if ( params[:settings] == "Account" || params[:settings].nil?)
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def personalSettings
		if ( params[:settings] == "Personal")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def adjustPoolsSettings
		if ( params[:settings] == "AdjustPools" || params[:settings].nil?)
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def availableDocSettings
		if ( params[:settings] == "AvailableDocs")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	
end

