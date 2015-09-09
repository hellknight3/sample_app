Setup instructions
run the following commands to populate the database, a postgres database is required to run the application locally
1) 'rake db:create'
2) 'rake db:migrate'
3) 'rake db:populate'

next inorder to have email working locally fidora needs to be setup with a "gmail_username" and "gmail_password" environmental variable

the seed data can be found in lib/tasks/sample_data.rake
user login information
director: director@example.org
admin: admin@example.org
doctor: exampleDoc-1@example.org
patient: examplePat-1@example.org
all passwords are 'foobar'
