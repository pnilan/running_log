require 'spec_helper'

describe "Password reset pages" do

	subject { page }

	describe "reset password page" do
		before { visit '/password_resets/new' }

		let(:submit) { "Reset Password" }

		it { should have_title("Password reset") }
		it { should have_content("Password Reset") }

		describe "when requesting password reset" do
			before do
				fill_in "email-reset", with: "user@example.com"
				click_button submit
			end

			it { should have_content("email sent") }
		end
	end
end
