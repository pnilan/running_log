require 'spec_helper'

describe "Activity pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before do 
		FactoryGirl.create(:type)
		sign_in user
	end

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
				select "Recovery", :from => "activity[type_id]"
				fill_in "date", with: Date.today
			end

			it "should create an activity" do
				expect { click_button "Add new activity!"}.to change(Activity, :count).by(1)
			end

		end
	end

	describe "editing an activity" do
		before do
			FactoryGirl.create(:activity, user: user)
			visit edit_activity_path(activity)
		end

	end

	describe "activity destruction" do
		before { FactoryGirl.create(:activity, user: user) }
		

		describe "as correct user" do

			it "should delete an activity"
		end
	end
end
