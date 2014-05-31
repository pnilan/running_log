FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "Person#{n}"}
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
		distance { 1 + rand(10) }
		duration { distance * 360 }
		pace 360
		content "Lorem ipsum"
		calories 1000
		bpm 120
		user
		type_id 1
	end
end