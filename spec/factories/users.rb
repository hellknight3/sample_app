require 'faker'

FactoryGirl.define do
	factory :user do |f|
		#f.name = "Joe"
		#f.email = "something@gmail.com"
		#f.password = "foobar"
		#f.password_confirmation = "foobar"
		f.name{Faker ::Name.name}
		f.password{Faker ::Name.name}
		f.email{Faker ::Internet.email}
		f.password_confirmation = f.password
		
	end
end