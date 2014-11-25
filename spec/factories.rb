require 'faker'

FactoryGirl.define do
	factory :user do 

		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
		password_confirmation'foobar'

		
	end
	
	factory :pool do 
		name{Faker::Name.name}
		institution{Faker::Name.name}
		description{Faker::Name.name}
		specialization{Faker::Name.name}
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
	factory :userInvalid, parent: :user do 

		name{Faker::Name.name}
		password'foo'
		email{Faker::Internet.email}
		password_confirmation'bar'

		
	end
	factory :patientInvalid do 
		userInvalid
	end
	factory :doctorInvalid do |f|

		userInvalid

		
	end
	factory :adminInvalid do |f|
		userInvalid
	end
end