namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		1.times do |n|
			name=Faker::Name.name
			email="admin@example.org"
			password = "foobar"
			admin=Admin.create!()
			admin.build_user(name: name,
				     email: email,
				     password: password,
				     password_confirmation: password)
			unless admin.save
				puts "error"
			end
		end
		99.times do |n|
			name=Faker::Name.name
			email="examplePat-#{n+1}@example.org"
			password = "foobar"
			patient=Patient.create!()
			 patient.build_user(name: name,
				     email: email,
				     password: password,
				     password_confirmation: password)
			unless patient.save
				puts "error"
			end
		end
		10.times do |n|
			name=Faker::Name.name
			email="exampleDoc-#{n+1}@example.org"
			password = "foobar"
			doctor=Doctor.create!()
			doctor.build_user(name: name,
				     email: email,
				     password: password,
				     password_confirmation: password)
			unless doctor.save
				puts "error"
			end
		end
		10.times do |n|
			name=Faker::Name.name
			description="sample description"
			institution="sample institution"
			specialization="sample specialization"
			Pool.create!(name: name,
			description: description,
			institution: institution,
			specialization: specialization)
			
			
		
		end
		

			
		
		
	end
end
