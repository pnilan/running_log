require 'spec_helper'

describe "Static Pages" do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_content("SecondWind") }
		it { should have_title(full_title('')) }
		it { should_not have_title('| Home') }

	end

	describe 'Contact page' do
		before { visit contact_path }

		it {should have_content('Contact Us') }
		it {should have_title(full_title('Contact Us')) }
	end 	

	describe 'About page' do
		before { visit about_path }

		it {should have_content('About Us') }
		it {should have_title(full_title('About Us')) }
	end 
end