class AppointmentsController < ApplicationController
	before_action :signed_in, only: [:new,:edit, :update, :index,:new,:create]
    before_action :is_doctor, only: [:new,:create,:edit, :update]
    respond_to :html, :js
  def new
	  @user = current_user
	  @appointment = Appointment.new
      #@pools = @user.pools
      respond_to do |format|
        format.js {render layout: false}
      end
  end

  def create
    @user = current_user
	@appointment =Appointment.new(appointment_params)	
	if @appointment.save
		@messageDoc = Message.new(:messageable_id => @appointment.id,:messageable_type => "Appointment", :user_id => current_user.id, :message => current_user.name+" Started appointment")
		@messageDoc.updated_at = DateTime.now
		if defined?(params[:appointment][:patient_id]) && params[:appointment][:patient_id]!= "" && !params[:appointment][:patient_id].nil?
			@patient = Patient.find(params[:appointment][:patient_id])
			@messagePat = Message.new(:messageable_id => @appointment.id,:messageable_type => "Appointment", :user_id => @patient.user.id, :message => @patient.user.name+" added to appointment")
			@messagePat.updated_at = DateTime.now
		end
		if defined?(@messagePat) 
			if @messageDoc.save && @messagePat.save
			  flash[:notice]="Successfully created appointment"
              Activity.create(:user_id => current_user.id,:trackable => @appointment,:action => "created appointment")
		      #redirect_to appointments_path
			else 
				flash[:alert]="Failed to create appointment"
                #render 'new'
			end
		else
			if @messageDoc.save
				flash[:notice]="Successfully created appointment"
              Activity.create(:user_id => current_user.id,:trackable => @appointment,:action => "created appointment")
		      #redirect_to appointments_path
			else 
				#flash[:alert]="Failed to create appointment"
                #render 'new'
			end
		end
	end
		
  end

  def index
    #@test = current_user.appointments
      #@activity=Activity.new
      #@activity = {:user => current_user, :action => :index, :trackable => self,:message => "#{current_user.name} viewed their appointments"}
		if params[:Appointment]=="Closed"
			@messages = Message.joins("INNER JOIN appointments on appointments.id = messages.messageable_id").where("messageable_type = ? and user_id = ?  and end_time is not null",'Appointment', current_user.id).select(:messageable_id).distinct
		elsif params[:Appointment]=="Future"
			@messages = Message.joins("INNER JOIN appointments on appointments.id = messages.messageable_id").where("messageable_type = ? and user_id = ?  and end_time is null and start_time > ?",'Appointment', current_user.id, DateTime.now).select(:messageable_id).distinct
		else
			#the Open case which is default
			@messages = Message.joins("INNER JOIN appointments on appointments.id = messages.messageable_id").where("messageable_type = ? and user_id = ?  and end_time is null and start_time < ?",'Appointment', current_user.id, DateTime.now).select(:messageable_id).distinct
		end
	end
  def edit
    @appointment=Appointment.find(params[:id])
  end
def update
		if(params[:appointment][:func] == "destroy")
			Appointment.find(params[:appointment][:appointment_id]).destroy
			flash[:notice]="Successfully destroyed appointment"
			redirect_to appointments_path
		elsif(params[:appointment][:func] == "close")
			@appointment=Appointment.find(params[:id])
			@appointment.update_attribute(:end_time, params[:appointment][:end_time])
			redirect_to appointments_path({Appointment: "Open"})
        elsif(defined?(params[:appointment][:name]))
          @appointment=Appointment.find(params[:id])
          if @appointment.update_attributes(appointment_params)
            Activity.create(:user_id => current_user.id, :trackable => @appointment,:action => "updated appointment")
            redirect_to appointments_path({Appointment: "Open"})
          else
            flash[:alert]="there was a problem submiting you changes make sure there are no errors in your submission and then try again"
            render "edit"
          end
		end
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
                flash[:notice]="Please sign in."
              respond_to do |format|
				format.html {redirect_to signin_url, notice: "Please sign in."}
                format.js { render :js => "window.location.href = ('#{signin_url}');"}
              end
			end
		end
    def is_doctor
      if !is_doctor? 
        flash[:alert]="Only doctors can create appointments."
        redirect_to appointments_path
      end
    end
end
