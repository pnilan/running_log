require 'spec_helper'

describe "Activity pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "activity creation" do

		before { visit new_activity_path }

		describe "with invalid information" do

			it "should not create an activity" do
				expect { click_button "Add new activity!"}.not_to change(Activity, :count)
			end

			describe "error messages" do
				before { click_button "Add new activity!" }
				it { should have_content("error") }
			end
		end

		describe "with valid information" do

			before do
				fill_in "type", with: "1"
				fill_in "date", with: Date.today
			end

			it "should create a micropost" do
				expect { click_button "Add new activity!"}.to change(Activity, :count).by(1)
			end

		end
	end
end
