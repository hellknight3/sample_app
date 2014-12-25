class Admin < ActiveRecord::Base
	has_one :user, as: :profile, dependent: :destroy
	#accepts nested attributes makes it so when you find the admin model you can then say admin_var_name.user to pull the user of the profile out.
	#very useful since the alternative would be querying the database manually and finding the user based on the admin id
	accepts_nested_attributes_for :user
end
