require 'spec_helper'

describe Activity do

	let(:user) { FactoryGirl.create(:user) }

	before do
		@activity = user.activities.build(date: Date.today, distance: 10.00, duration: 3600, pace: 360, content: "Lorem ipsum", user_id: user.id, type_id: 1)
	end

	subject { @activity }

	it { should respond_to(:date) }
	it { should respond_to(:distance) }
	it { should respond_to(:duration) }
	it { should respond_to(:pace) }
	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:type_id) }
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

	describe "when type_id is not present" do
		before { @activity.type_id = nil }
		it { should_not be_valid }
	end

	describe "when content is too long" do
		before { @activity.content = "a" * 1001 }
		it  { should_not be_valid }
	end

	# describe "when distance and duration are present but pace is not" do
	# 	before do
	# 		@activity.duration = 60
	# 		@activity.distance = 10
	# 		@activity.pace = nil
	# 	end

	# 	it { should_not be_valid }
	# end
end