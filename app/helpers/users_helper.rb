module UsersHelper
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
	
end
 def go_to_home(user=current_user)
          if is_admin?(user)
            admin_path(user.profile_id)
          elsif is_patient?(user)
            patient_path(user.profile_id)
          elsif is_doctor?(user)
            doctor_path(user.profile_id)
          end

        end
