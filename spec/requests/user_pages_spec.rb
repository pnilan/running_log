require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		let(:submit) { "Create my account" }

		it { should have_content("Create an account") }
		it { should have_title("Sign up") }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "user[username]",			with: "example_user"
				fill_in "user[name]",		with: "Example User"
				fill_in "user[email]",			with: "example@user.com"
				fill_in "user[password]",			with: "foobar"
				fill_in "user[password_confirmation]",		with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

		describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'user@example.com') }

				it { should have_link('Sign out') }
				it { should have_title(full_title('')) }
				it { should have_selector('div.alert.alert-success', text: "SecondWind!") }
			end
		end
    end

    describe "profile page" do
    	let(:user) { FactoryGirl.create(:user) }
    	before { visit user_path(user) }

    	it { should have_content(user.username) }
    	it { should have_content(user.name) }
    	it { should have_title(user.username) }
    end

    describe "edit" do
    	let(:user) { FactoryGirl.create(:user) }

    	before do
    		sign_in(user)
    		visit edit_user_path(user)
    	end

    	describe "page" do
    		it { should have_content("Update your settings") }
    		it { should have_title("Edit settings") }
    	end

    	describe "with invalid information" do
    		before do
    			fill_in "Password",	with: "a"
    			click_button "Save changes"
    		end

    		it { should have_content("error") }
    	end
    end
end