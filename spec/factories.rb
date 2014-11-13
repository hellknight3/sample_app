require 'faker'

FactoryGirl.define do
	factory :user do 

		name{Faker::Name.name}
		password'foobar'
		email{Faker::Internet.email}
		password_confirmation'foobar'

		
	end
	factory :patient do |f|

		f.name{Faker::Name.name}
		f.password 'foobar'
		f.email{Faker::Internet.email}
		f.password_confirmation 'foobar'

		
	end
	factory :doctor do |f|

		f.name{Faker::Name.name}
		f.password 'foobar'
		f.email{Faker::Internet.email}
		f.password_confirmation 'foobar'

		
	end
	factory :admin do |f|

		f.name{Faker::Name.name}
		f.password 'foobar'
		f.email{Faker::Internet.email}
		f.password_confirmation 'foobar'

		
	end
end