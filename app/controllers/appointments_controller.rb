class AppointmentsController < ApplicationController
  def new
  @user = current_user
  @appointment = Appointment.new
  end

  def create
	@appointment =Appointment.new(appointment_params)
	if current_user.profile_type=="Patient"
		@appointment.patient_id=current_user.profile_id
		@appointment.doctor_id=params[:appointment][:profile_id]
	else #if current_user.profile_type=="Doctor"
		@appointment.doctor_id=current_user.profile_id
		@appointment.patient_id=params[:appointment][:profile_id]
		
	end	

	if @appointment.save
		@message = Message.new
		
		@message.appointment_id=@appointment.id
		if @message.save
		@message.update_attribute(:message, params[:message][:message])
			flash[:success]="Successfully sent message"
		else
			flash[:error]="message not saved"
		end
		redirect_to appointments_path
	else
		render 'new'
	end
		
  end

  def index
	if current_user.profile_type =="Doctor"
		@doctor=Doctor.find(current_user.profile_id)
		@appointments=Appointment.find(:all, :conditions =>["doctor_id = :doc",{:doc => @doctor.id}])
	elsif current_user.profile_type=="Patient"
		@patient=Patient.find(current_user.profile_id)
		@appointments=Appointment.find(:all, :conditions =>["patient_id = :doc",{:doc => @patient.id}])
	end
  end
def update
		if(params[:appointment][:func] == "destroy")
			Appointment.find(params[:appointment][:appointment_id]).destroy
			flash[:success]="Destroyed appointment"
			redirect_to appointments_path
		elsif(params[:appointment][:func] == "create")
			redirect_to new_message_path({appointment_id:params[:appointment][:appointment_id]})
		end
end
  
  def show
	@appointment=Appointment.find(params[:id])
  end

  
  private
  def appointment_params
	
	
	#params.require(:message).permit(:content)
	
  end
end
