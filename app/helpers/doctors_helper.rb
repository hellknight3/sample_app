module DoctorsHelper
	def acceptedPage
		if ( params[:patient_status] == "Accepted")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def pendingPage
		if ( params[:patient_status] == "Pending")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def rejectedPage
		if ( params[:patient_status] == "Rejected")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
end
