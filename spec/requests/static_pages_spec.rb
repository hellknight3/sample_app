require 'spec_helper'

describe "Static pages" do
	subject{page}
	shared_examples_for "all static pages" do
		#have_selector finds the HTML attribute with h1, and checks to see that the text matches heading
		#see the comments below for origin of heading and page_title
		it { should have_selector('h1', text: heading) }
		#this is linked to the helper method in called full_title, it is under spec/helpers/application_helper_spec.rb
		it { should have_title(full_title(page_title)) }
	end
	describe "Home page" do
		#go to the root of the application for example localhost:3000/ the visit command is used to go to
		#path that is defined in config/routes.rb, it gets a bit more complicated from there but should be enough for now. 
		before {visit root_path}
		#checks the title, the title is defined in the Views with provide(:title,"") part. 
		#This is used in this part only because of how the headers are created, with something like 
		#"sample app | title" dont want the title part to exist at the root because it looks unnatural and redundant.
		it { should_not have_title('| Home') }
		#the let statements define the variables heading and page_title that are used in the shared_examples part. 
		let(:heading) {'Sample App'}
		let(:page_title) {''}
		#it should behave like part uses the variables defined above and pushes them up to the shared_example_for part.
		it_should_behave_like "all static pages"
	end
	describe "Help page" do
		#checks the config/routes.rb file and sees the line 
		#match '/help', to "controller#function", via: POST command
		#the line help is used to identify what to look up in the routes file whereas having path just tells the compiler to look it up.
		#i'm not 100% sure on this so i may be wrong on some aspects of this so if you need to know more may want to look up on google for something like path routing rails
		before{visit help_path}

		let(:heading) {'Help'}
		let(:page_title) {'Help'}
		it_should_behave_like "all static pages"
	end
	describe "About page" do
		before{visit about_path}
		let(:heading) {'About Us'}
		let(:page_title) {'About Us'}
		it_should_behave_like "all static pages"
	end 
	describe "Contact page" do
		before{visit contact_path}
		let(:heading) {'Contact'}
		let(:page_title) {'Contact'}
		it_should_behave_like "all static pages"
	end
end
