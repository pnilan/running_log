require 'spec_helper'

describe Activity do

	let(:user) { FactoryGirl.create(:user) }

	before do
		@activity = user.activities.build(date: Date.today, distance: 10.00, duration: 3600, pace: 360, content: "Lorem ipsum", user_id: user.id, run_type: "test")
	end

	subject { @activity }

	it { should respond_to(:date) }
	it { should respond_to(:distance) }
	it { should respond_to(:duration) }
	it { should respond_to(:pace) }
	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:run_type) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when date is not present" do
		before { @activity.date = nil }
		it { should_not be_valid }
	end

	describe "when user_id is not present" do
		before { @activity.user_id = nil }
		it { should_not be_valid }
	end

	describe "when run_type is not present" do
		before { @activity.run_type = nil }
		it { should_not be_valid }
	end

	describe "when content is too long" do
		before { @activity.content = "a" * 1001 }
		it  { should_not be_valid }
	end
end