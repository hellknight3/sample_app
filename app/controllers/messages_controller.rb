class MessagesController < ApplicationController
  def show
  @user=current_user
  end
  def index
	@users = Message.where("messageable_type = ? and( user_id = ? or messageable_id = ?)",'User', current_user.id,current_user.id).select(:messageable_id, :user_id).distinct.all
	#@messages=User.joins('INNER JOIN messages ON messages.messageable_id =user.id') 
	#where(["user_id = :user and messageable_type = :messageable_type",{:user => current_user.id, :messageable_type => User.name}]).uniq
	#find(:all,:conditions =>["user_id = :user and messageable_type = :messageable_type",{:user => current_user.id, :messageable_type => User.name}]).uniq(:messageable_id)
 #@messages=Message.all
 end
  def new
	@user=current_user
	@message=Message.new
	if (params[:messageable_type] == Appointment.name)
		@messages=Message.where("messageable_type = ? and messageable_id = ?",'Appointment', params[:messageable_id]).select(:messageable_id, :user_id,:message).all
		
	else
		@messages=Message.find(:all, :conditions =>["(messageable_id = :user or user_id = :user) and messageable_type = :messageable_type",{:user => params[:messageable_id], :messageable_type => User.name}])
		
	end
	
	@users=@user.pools.select(:user_id).uniq.all
  
  end

  def create

	@message = Message.new(message_params)
	  if @message.save
		#@message.update_attribute(:appointment_id, params[:internal][:appointment_id])
		#@message.update_attribute(:user_id,current_user.id)
		flash[:success] = "message sent successfully"
		redirect_to new_message_path({messageable_id:@message.messageable_id, messageable_type:@message.messageable_type})
	  end
  end
  
  private
  
  def message_params
	params.require(:message).permit(:message,:user_id,:messageable_id, :messageable_type)
  end
end
