require 'faker'

FactoryGirl.define do

	#create user
	factory :user do 
		#assign randomly generated values to the attributes
		#expect for the pw 
		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
		password_confirmation'foobar'		
	end

	#create a pool
	factory :pool do 
		#assign randomly generated values to the attributes
		name{Faker::Name.name}
		institution{Faker::Name.name}
		description{Faker::Name.name}
		specialization{Faker::Name.name}
	end
	
	#create patient
	factory :patient do 
		user#create a user
	end
	#create a doctor
	factory :doctor do |f|
		user#create a user
	end
	#create an admin
	factory :admin do |f|
		user#create a user
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
	
	factory :answer do
		response{Faker::Name.name}
	end
	
	factory :appointment do
		name{Faker::Name.name}
		description{Faker::Name.name}
	end
	
	factory :message do
		message{Faker::Name.name}
	end
	 
	
end