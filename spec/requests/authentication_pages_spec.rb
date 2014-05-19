require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_content('Sign in') }
		it { should have_title('Sign in') }
		it { should have_link('Forgot password?') }

		describe "with invalid information" do
			before { click_button 'signin_button' }

			it { should have_title('Sign in') }
			it { should have_selector('div.alert.alert-error') }

			describe 'after visiting another page' do
				before { click_link "Home", match: :first }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe 'with valid information' do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "email_signin", 	with: user.email.upcase
				fill_in "password_signin",  with: user.password
				click_button "signin_button"
			end

			it { should have_title(full_title('')) }
			it { should have_link('Profile',		href: user_path(user)) }
			it { should have_link('Sign out',		href: signout_path) }

			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should_not have_link('Sign out') }
			end
		end
	end
end
