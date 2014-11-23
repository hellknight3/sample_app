class AppointmentsController < ApplicationController
  def new
  @user = current_user
  @appointment = Appointment.new
  end

  def create
	@appointment =Appointment.new(appointment_params)
		if @appointment.save
			flash[:success]
			redirect_to @appointment
		else
			render 'new'
		end
  end

  def index
	@appointment=Appointment.find(params[:id])
  end

  def show
	@appointment=Appointment.find(params[:id])
  end
  
  private
  def appointment_params
	params.require(:appointment).permit(:doctor_id,:patient_id)
  end
end
