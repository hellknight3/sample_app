class MessagesController < ApplicationController
  # show currently not used for messages
# def show
#	@user=current_user
#  end

  def index
	@users = Message.where("messageable_type = ? and( user_id = ? or messageable_id = ?)",'User', current_user.id,current_user.id).pluck("Distinct messageable_id, user_id")
	@users.each do |user|
		@temp =@users.count{|x,i| x==user[0] && i==user[1] || x==user[1] && i==user[0]}
		if @temp>1
			@users.delete([user[1],user[0]])
		end
	end
	#@users = Message.where("messageable_type = ? and( user_id = ? or messageable_id = ?)",'User', current_user.id,current_user.id).select(:messageable_id,:user_id, :created_at).order("created_at ASC").group(:messageable_id, :user_id).all
	#the list of your current contacts. it is displayed in the popup.
	@contacts=User.joins('INNER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id').uniq.all
	@message=Message.new
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
		@appointment=Appointment.find(params[:messageable_id])
	else
		@messages=Message.where("((messageable_id = ? and user_id = ?)   or (user_id = ? and messageable_id = ?)) and messageable_type = ?",current_user.id,params[:messageable_id],current_user.id,params[:messageable_id],User.name).all
		#, :messageable_type => User.name, :messageable_id=>params[:messageable_id]}])
		
	end
    if(current_user.profile_type == "Doctor") 
    @users=User.joins('LEFT OUTER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id').uniq.all
    else
      
    @users=User.joins('LEFT OUTER JOIN permissions ON users.id = permissions.user_id INNER JOIN pools ON pools.id = permissions.pool_id').where("users.profile_type == 'Doctor'").uniq.all
    end
  
  end

  def create

	@message = Message.new(message_params)
	  if @message.save
		#@message.update_attribute(:appointment_id, params[:internal][:appointment_id])
		#@message.update_attribute(:user_id,current_user.id)
		flash[:notice] = "message sent successfully"
		redirect_to new_message_path({messageable_id:@message.messageable_id, messageable_type:@message.messageable_type})
	  end
  end
  
  private
  
  def message_params
	params.require(:message).permit(:message,:user_id,:messageable_id, :messageable_type)
  end
end
