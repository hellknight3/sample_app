require 'faker'

FactoryGirl.define do
	factory :user do 

		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
		password_confirmation'foobar'

		
	end
	factory :patient do 
		user
	end
	factory :doctor do |f|

		user

		
	end
	factory :admin do |f|

		user
		
	end
end