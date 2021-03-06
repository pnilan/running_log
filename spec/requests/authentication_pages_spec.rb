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

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			let(:activity) { FactoryGirl.create(:activity, user: user) }

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "email_signin", 	with: user.email.upcase
					fill_in "password_signin",  with: user.password
					click_button "signin_button"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						expect(page).to have_title('Edit settings')
					end
				end
			end

			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title('Sign in') }
				end

				describe "submitting to the update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(signin_path) }
				end

				describe "submitting to the destroy action" do
					before { delete user_path(user) }
					specify { expect(response).to redirect_to(signin_path) }
				end
			end

			describe "in the Activities controller" do

				describe "visiting the index page" do
					before { visit activities_path }
					it { should have_title('Sign in') }
				end

				describe "submitting to the create action" do
					before { post activities_path }
					specify { expect(response).to  redirect_to(signin_path) }
				end

				describe "submitting to the destroy action" do
					before { delete activity_path(activity) }
					specify { expect(response).to redirect_to(signin_path) }
				end

				describe "submitting to the update action" do
					before { patch activity_path(activity) }
					specify { expect(response).to redirect_to(signin_path) }
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			let(:activity) { FactoryGirl.create(:activity, user: wrong_user) }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the User#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match(full_title('Edit user')) }
				specify { expect(response).to redirect_to(dashboard_home_path) }
			end

			describe "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(dashboard_home_path) }
			end

			describe "submitting a PATCH request to the Activities#update action" do
				before { patch activity_path(activity) }
				specify { expect(response).to redirect_to(dashboard_home_path) }
			end
		end
	end
end