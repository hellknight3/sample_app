class AppointmentsController < ApplicationController
	before_action :signed_in, only: [:new,:show,:edit, :update, :index]
  def new
	  @user = current_user
	  @appointment = Appointment.new
	  
  end

  def create
	@appointment =Appointment.new(appointment_params)	
	if @appointment.save
		@messageDoc = Message.new(:messageable_id => @appointment.id,:messageable_type => "Appointment", :user_id => current_user.id, :message => current_user.name+" Started appointment")
		@messageDoc.updated_at = DateTime.now
		if defined?(params[:appointment][:patient_id]) && params[:appointment][:patient_id]!= ""
		@patient = Patient.find(params[:appointment][:patient_id])
		@messagePat = Message.new(:messageable_id => @appointment.id,:messageable_type => "Appointment", :user_id => @patient.user.id, :message => current_user.name+" added to appointment")
		@messagePat.updated_at = DateTime.now
		end
		if defined?(@messagePat) 
			if @messageDoc.save && @messagePat.save
				flash[:notice]="Successfully created appointment"
			else 
				flash[:alert]="Failed to create appointment"
			end
		else
			if @messageDoc.save
				flash[:notice]="Successfully created appointment"
			else 
				flash[:alert]="Failed to create appointment"
			end
		end
		redirect_to appointments_path
	else
		render 'new'
	end
		
  end

  def index
		if params[:Appointment]=="Closed"
			@messages = Message.joins("INNER JOIN appointments on appointments.id = messages.messageable_id").where("messageable_type = ? and user_id = ?  and end_time is not null",'Appointment', current_user.id).select(:messageable_id).distinct.all
		elsif params[:Appointment]=="Future"
			@messages = Message.joins("INNER JOIN appointments on appointments.id = messages.messageable_id").where("messageable_type = ? and user_id = ?  and end_time is null and start_time > ?",'Appointment', current_user.id, DateTime.now).select(:messageable_id).distinct.all
		else
			@messages = Message.joins("INNER JOIN appointments on appointments.id = messages.messageable_id").where("messageable_type = ? and user_id = ?  and end_time is null and start_time < ?",'Appointment', current_user.id, DateTime.now).select(:messageable_id).distinct.all
		end
	end
def update
		if(params[:appointment][:func] == "destroy")
			Appointment.find(params[:appointment][:appointment_id]).destroy
			flash[:notice]="Successfully destroyed appointment"
			redirect_to appointments_path
		elsif(params[:appointment][:func] == "close")
			@appointment=Appointment.find(params[:id])
			@appointment.update_attribute(:end_time, params[:appointment][:end_time])
			redirect_to appointments_path({Appointment: "Closed"})
		end
end
  
  def show
	@appointment=Appointment.find(params[:id])
  end

  
  private
  def appointment_params
	
	params.require(:appointment).permit(:name, :description,:start_time)
	
  end
	def message_params
		params.require(:message).permit!
	end
	def signed_in
			unless signed_in?#checks if the user is currently signed in, the function is housed in the sessions helper for in depth analysis
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
end