module UsersHelper
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
	
end
 def go_to_home
          if is_admin
            admin_path(current_user.profile_id)
          elsif is_patient
            patient_path(current_user.profile_id)

          elsif is_doctor
            doctor_path(current_user.profile_id)
          end

        end
