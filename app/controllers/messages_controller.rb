class MessagesController < ApplicationController
  def show
  @user=current_user
  end

  def new
	@user=current_user
	@message=Message.new
	@messages=Message.find(:all, :conditions =>["appointment_id = :appointment",{:appointment => params[:appointment_id]}])
	
  
  end

  def create
	@message = Message.new(message_params)
	  if @message.save
		@message.update_attribute(:appointment_id, params[:internal][:appointment_id])
		@message.update_attribute(:user_id,current_user.id)
		flash[:success] = "message sent successfully"
		redirect_to new_message_path({appointment_id:params[:internal][:appointment_id]})
	  end
  end
  
  private
  
  def message_params
	params.require(:message).permit(:message)
  end
end
