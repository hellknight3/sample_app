class MessagesController < ApplicationController
  def show
  @user=current_user
  end

  def new
	@user=current_user
	@message=Message.new
	@messages=Message.find(:all, :conditions =>["appointment_id = :appointment",{:appointment => params[:appointment_id]}])
	if @user.profile_type=="Doctor"
		@recipient=Patient.find(Appointment.find(params[:appointment_id]).patient_id)
	elsif @user.profile_type=="Patient"
		@recipient=Patient.find(Appointment.find(params[:appointment_id]).doctor_id)
	end
  
  end

  def create
	@message = Message.new(message_params)
	  if @message.save
		@message.update_attribute(:appointment_id, params[:message][:appointment_id])
		flash[:success] = "message sent successfully"
		redirect_to new_message_path({appointment_id:params[:message][:appointment_id]})
	  end
  end
  
  private
  
  def message_params
	params.require(:message).permit(:message)
  end
end
