Given(/^they edit themselves$/) do
  if current_user.profile_type == "Admin"
    @trackable=current_user.profile
    visit edit_admin_path(current_user.profile_id)
  elsif current_user.profile_type == "Doctor"
    @trackable=current_user.profile
    visit edit_doctor_path(current_user.profile_id)
  elsif current_user.profile_type == "Patient"
    @trackable=current_user.profile
    visit edit_patient_path(current_user.profile_id)
  end
end

