require 'spec_helper'

describe "Activity pages", type: :request do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }

	describe "activity creation" do


		before do 
			sign_in user
			visit "/activities/new"
		end

		let(:submit) { "Log it!" }

		describe "with invalid information" do

			it "should not create an activity" do
				expect { click_button submit, match: :first }.not_to change(Activity, :count)
			end

			describe "error messages" do
				before { click_button submit, match: :first }
				it { should have_content("error") }
			end
		end

		describe "with valid information" do

			before do
				select "Endurance", :from => "Run type", match: :first
				fill_in "date", match: :first, with: Date.today
			end

			it "should create an activity" do
				expect { click_button submit, match: :first }.to change(Activity, :count).by(1)
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
