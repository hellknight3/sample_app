module AppointmentsHelper
def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  def openAppointmentPage
		if ( params[:Appointment] == "Open" || params[:Appointment]==nil)
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def futureAppointmentPage
		if ( params[:Appointment] == "Future")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
	def closedAppointmentPage
		if ( params[:Appointment] == "Closed")
			return "btn btn-info"
		else
			return "btn btn-default"
		end
	end
end
