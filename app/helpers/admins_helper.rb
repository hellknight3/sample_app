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
	def show_user(user_type, user)
		if user_type =="Doctor"
			return doctor_path(user)
		elsif user_type=="Admin"
			return admin_path(user)

		elsif user_type=="Patient"
			return patient_path(user)

		end
		
	end
end
