module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies[:remember_token] = {value: remember_token, expires: 20.minutes.from_now.utc}
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end
	def signed_in?
		!current_user.nil?
	end
	def current_user=(user)
			  @current_user=user
	end
	def current_user
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end
	def get_patient(user)
		return Patient.find(user.profile_id)	
	end
	def current_doctor
		Doctor.find(current_user.profile_id)
	end
	def current_user?(user)
		user==current_user
	end
	def is_doctor?(user)
		user.profile_type=="Doctor"
	end
	def is_doctor
		is_doctor?(current_user)==true
	end
	def is_admin?(user)		
		user.profile_type=="Admin"
	end
	def is_admin
		is_admin?(current_user)==true
	end
	def is_patient?(user)
		user.profile_type=="Patient"
	end
	def is_patient
		is_patient?(current_user)==true
	end
	def is_director?(user)
		puts Admin.find(user.profile_id).director
		 if is_admin?(user)
			Admin.find(user.profile_id).director==true
		else
			false
		end
	end
	def is_director	
	
		 is_director?(current_user)==true
	end
	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
	def store_location
		session[:return_to] =request.url if request.get?
	end
	def profile(user)
		if is_patient?(user)
			return Patient.find(user.profile_id)
		elsif is_doctor?(user)
			return Doctor.find(user.profile_id)
		elsif is_admin?(user)
			return Admin.find(user.profile_id)
		end
	end		
end
