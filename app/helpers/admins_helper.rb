module AdminsHelper
	def adminPage
		if ( params[:user_type] == "Admin")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def doctorPage
		if ( params[:user_type] == "Doctor")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def patientPage
		if ( params[:user_type] == "Patient")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
end
