FactoryGirl.define do
	factory :user do
		sequence(:name) 	{ |n| "Person #{n}"}		
		sequence(:email) 	{ |n| "Person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		password_reset_token "anything"

		factory :admin do
			admin true
		end
	end

	factory :activity do
		date Date.today
		distance "10"
		duration "3600"
		pace "360"
		content "Lorem ipsum"
		user
		run_type "test"
	end
end