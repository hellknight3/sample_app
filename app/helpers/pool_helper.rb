module PoolHelper
def myPoolPage
		if ( params[:pools] == "Personal" || params[:pools]==nil)
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def otherPoolPage
		if ( params[:pools] == "Other")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
end
