require 'faker'

FactoryGirl.define do
	#create user
  factory :userPatient, class: User do 
		#assign randomly generated values to the attributes
		#expect for the pw 
		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
        password_confirmation'foobar'		
        association :profile, factory: :patient
        #    after(:build) do |user|
	 #      profile.user ||= FactoryGirl.build(:user, :profile => profile)
    #    end
    end
   factory :user do 
		#assign randomly generated values to the attributes
		#expect for the pw 
		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
        password_confirmation'foobar'		
#        association :profile, factory: :doctor
        #    after(:build) do |user|
	 #      profile.user ||= FactoryGirl.build(:user, :profile => profile)
    #    end
    end



   factory :userDoctor, class: User do 
		#assign randomly generated values to the attributes
		#expect for the pw 
		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
        password_confirmation'foobar'		
        association :profile, factory: :doctor
        #    after(:build) do |user|
	 #      profile.user ||= FactoryGirl.build(:user, :profile => profile)
    #    end
    end

  factory :userAdmin, class: User do 
		#assign randomly generated values to the attributes
		#expect for the pw 
		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
        password_confirmation'foobar'		
        association :profile, factory: :admin
        #    after(:build) do |user|
	 #      profile.user ||= FactoryGirl.build(:user, :profile => profile)
    #    end
    end
  factory :userDirector, class: User do 
		#assign randomly generated values to the attributes
		#expect for the pw 
		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
        password_confirmation'foobar'		
        association :profile, factory: :admin, director: true
  end

	#create a pool
	factory :pool do 
		#assign randomly generated values to the attributes
		institution
		name{Faker::Name.name}
		description{Faker::Name.name}
		specialization{Faker::Name.name}
 
	#	institution_id{Faker::Number.number(2)}
	end

	
	#create patient
	factory :patient do 
	#	usePatientr#create a user
		emergencyContact{Faker::Name.name}
		emergencyPhoneNumber{Faker::PhoneNumber::phone_number}
		familyDoctor{Faker::Name.name}
		phoneNumber{Faker::PhoneNumber::phone_number}
		height{Faker::Number.number(8)}
		weight{Faker::Number.number(9)}	
	end
	#create a doctor
	factory :doctor do |f|
	#	userDoctor#create a user
	end
	#create an admin
	factory :admin do |f|
      director{false}
     #   f.after_create {|a| FactoryGirl(:user, :profile => a)}
      #  userAdmin
      #   after(:build) do |admin|
      #      admin.user ||= FactoryGirl.build(:user, :admin => admin) 
      #  end
	end

factory :adminCreate, class: Admin do
  user
end

	factory :director do 
		admin
		director true
	end
	
	factory :answer do
		response{Faker::Name.name}
	end
	
	factory :appointment do
		name{Faker::Name.name}
		description{Faker::Name.name}
        start_time{DateTime.now.to_date}
        end_time{}
	end
	
	factory :message do
		message{Faker::Name.name}
        user
        association :messageable, factory: :user
	end
	 
	factory :institution do 
		name{Faker::Name.name}
		description{Faker::Name.name}
	end
    factory :appointmentMembership do
      pool
      appointment
    end 
	#create activity
	factory :activity do 
		association :user
		association :trackable, factory: :user
        message {"some informative message about action taking place"}
		action "an HTTP action"
 	end
end
